library(ggplot2)
library(tidyr)
library(dplyr)
library(multcomp)
library(drc)
library(patchwork)

calculate_inhibition = function(x,min,max){
    rownames(x) = x$Replicate
    x = x[c(-1)]
    x = log10(x)
    x_s2 = x - sum(sort(unlist(x))[1:min])/min
    x_s3 = signif((1 - (x_s2 / (sum(sort(unlist(x_s2),decreasing=TRUE)[1:max])/max))) * 100,4)
    return(list("plate_log10"=x,"plate_step2"=x_s2,"plate_step3"=x_s3))
}

write_results = function(listo,output_dir){
    if (!dir.exists(output_dir)) {dir.create(output_dir)}
    for (namae in names(listo)){
            write.csv(listo[[namae]],file=paste0("./",output_dir,"/",namae,".csv"))
        }
    }

dilutions = c(25,8.333333,2.77777778,0.925925926,0.308641975,0.102880658,0.034293553,0.011431184)
reps_per_dilution = 2
nogo = c("C_Media..No.Ab.","C_No.cells.virus.only")
models = list("LL3"=LL.3(),"LL4"=LL.4()) ### LL4 IS AN OPTION IF LL3 ISNT RIGHT

frames = list.files(pattern="*.csv")
myl = lapply(X=frames,FUN=read.csv)
names(myl) = gsub(".csv","",frames)

myl = lapply(X=myl,FUN=calculate_inhibition,16,48)

for (plate_name in names(myl)){
    plate = myl[[plate_name]]
    write_results(plate,output_dir=plate_name)
}

compounds = unique(colnames(myl[[1]][[1]]))
compounds = compounds[compounds != nogo]
frames_by_compound = list()
plots = list()

for (compound in compounds){
    print(compound)
    cross_plate = data.frame(row.names=seq(1,(reps_per_dilution*length(dilutions))))
    slope_arrays = list()
    for (plate_name in names(myl)){
        plate = myl[[plate_name]]
        cross_plate[[plate_name]] = plate[["plate_step3"]][[compound]]
    }
    cross_plate = pivot_longer(cross_plate,cols=everything(),names_to = "Plate",values_to = "Inhibition")
    cross_plate[["Dilutions"]] = sort(rep(dilutions,(length(myl)*reps_per_dilution)),decreasing=TRUE)
    frames_by_compound[[compound]] = cross_plate

    plate_list = split(cross_plate,cross_plate$Plate)
    predictions = list()
    plot_stats = list()
    for (namae in names(plate_list)){
        plate_df = plate_list[[namae]]
        res = NULL
        tryCatch({
            res = drm(plate_df$Inhibition ~ plate_df$Dilutions, fct=models[["LL3"]])
        },error = function(msg){
            print(paste0(compound, " HAS FAILED DOSE-RESPONSE MODEL"))
            return()
        })
        xmarker = (quantile(dilutions)[[2]]+quantile(dilutions)[[3]])/2
        dilution_array = expand.grid(Dilution=c(seq(min(dilutions),xmarker,length=200),seq(xmarker,max(dilutions),length=600)))

        prediction_frame = plate_df %>% group_by(Dilutions) %>% mutate("SD"=sd(Inhibition))
        df_grouped = prediction_frame %>%
            cbind("group"=rep(1:length(dilutions),each=reps_per_dilution)) %>%
            group_by(group) %>% 
            summarise(across(where(is.numeric), mean), .groups="drop") %>%
            cbind("Plate"=rep(namae,nrow(prediction_frame)/reps_per_dilution))
        df_grouped = df_grouped[,c(-1)]
        colnames(df_grouped) = c("AVG_Inhibition","Dilutions","SD","Plate")
        plot_stats[[namae]] = df_grouped
        pm = predict(res, newdata=dilution_array, interval="confidence")
        dilution_array$p = pm[,1]
        dilution_array$pmin = pm[,2]
        dilution_array$pmax = pm[,3]
        dilution_array$Plate = rep(namae,nrow(dilution_array))
        predictions[[namae]] = dilution_array
    }

    p = ggplot(data = frames_by_compound[[compound]])+
        scale_x_log10()+
        ylim(-20,120)+
        labs(title = paste0(compound," pct. Inhibition"),
        x = "Dilution (log scale)",
        y = "Inhibition")+
        theme_classic()

    for (name in names(predictions)){
        pred = predictions[[name]]
        stats = plot_stats[[name]]
        p = p + 
            geom_line(data=pred, aes(x=Dilution,y=p, color=Plate),lwd=1.2)+
            geom_point(data=stats, aes(x=Dilutions, y=AVG_Inhibition,color=Plate), shape=0, size=2.5, lwd=1.5)+
            geom_errorbar(data=stats, aes(x=Dilutions, ymin=AVG_Inhibition-SD, ymax=AVG_Inhibition+SD, color = Plate), width=.185, position=position_dodge(.9))
            #geom_errorbar(data=pred, aes(x=Dilution, ymin=pmin, ymax=pmax), width=.2, position=position_dodge(.9))
    }
    plots[[compound]] = p
}

iterations = ceiling(length(plots)/12)
nums = data.frame("start"=1,"end"=12)
for (i in 1:iterations){
    ind_s = paste0("plot",as.character(i))
    if (i == iterations){final=length(plots)}else{final=nums[["end"]]}
    p1 = patchwork::wrap_plots(plots[nums[["start"]]:final],ncol=4)
    ggsave(paste0(ind_s,"_LL3.pdf"),p1,height=10,width=16)
    nums = nums+12
}