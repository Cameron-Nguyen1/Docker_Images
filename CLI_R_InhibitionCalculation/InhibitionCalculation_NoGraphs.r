library(optparse)
library(stringr)

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

option_list = list(
  make_option(c("--input"), type="character", default=NULL,help="A UTF-8 formatted CSV containing inhibition data.", metavar="character"),
  make_option(c("--outDir"), type="character", default='.',help="Output directory.", metavar="character"),
  make_option(c("--inhibition_min_max"), type="character", default=NULL,help="#'s to determine min and max, i.e. '16,48' or '32,112'.", metavar="character")
)

pargs = parse_args(OptionParser(option_list=option_list))

frame = read.csv(pargs[["input"]])
minmax = str_split(pargs[["inhibition_min_max"]],pattern=",")
result = calculate_inhibition(x=frame,min=minmax[[1]],max=minmax[[2]])
write_results(result,output_dir=pargs[["outDir"]])