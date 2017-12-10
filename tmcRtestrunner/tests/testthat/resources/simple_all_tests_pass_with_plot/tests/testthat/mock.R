#In this file, the teacher can override R functions so that she/he can
#test whether the student has used some function (and maybe with the correct
#arguments)

assign("plot", function(...) {
    extras <- list(...)
    if(!exists("used_plot_args")) {
        used_plot_args <<- unlist(extras)
    } else {
        used_plot_args <<- list(unlist(used_plot_args), unlist(extras))
    }
    graphics::plot(...)
    if (file.exists("Rplots.pdf")) {
        file.remove("Rplots.pdf")
    }
}, envir = test_env)

assign("paste0", function(...) {
    extras <- list(...)
    if (!exists("used_paste_args")) {
        used_paste_args <<- unlist(extras)
    } else {
        used_paste_args <<- list(unlist(used_paste_args), unlist(extras))
    }
    base::paste0(...)
}, envir = test_env)
