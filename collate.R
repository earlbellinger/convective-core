star.dirs <- list.files('covs', full.names=T)

DF <- do.call(rbind, Map(function(star.dir) {
    covs <- list.files(file.path(star.dir, 'covs'), full.names=T)
    covs <- covs[grepl('_sk.dat$', covs)]
    do.call(rbind, Map(function(cov.file) {
        cov.DF <- read.table(cov.file, header=1)
        with(cov.DF, data.frame(
            M          = median(M),          e_M          = mad(M),
            Y          = median(Y),          e_Y          = mad(Y),
            Z          = median(Z),          e_Z          = mad(Z),
            age        = median(age),        e_age        = mad(age),
            CCB_mass   = median(CCB_mass),   e_CCB_mass   = mad(CCB_mass),
            CCB_radius = median(CCB_radius), e_CCB_radius = mad(CCB_radius),
            FM_mass    = median(FM_mass),    e_FM_mass    = mad(FM_mass),
            FM_radius  = median(FM_radius),  e_FM_radius  = mad(FM_radius)))
    }, cov.file=covs))
}, star.dir=star.dirs))

write.table(DF, 'cc.dat', row.names=F, quote=F)
