% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/profile.R
\name{gcs_first}
\alias{gcs_first}
\alias{gcs_last}
\title{Save your R session to the cloud on startup/exit}
\usage{
gcs_first(bucket = Sys.getenv("GCS_SESSION_BUCKET"))

gcs_last(bucket = Sys.getenv("GCS_SESSION_BUCKET"))
}
\arguments{
\item{bucket}{The bucket holding your session data. See Details.}
}
\description{
Place within your \code{.Rprofile} to load and save your session data automatically
}
\details{
The folder you want to save to Google Cloud Storage will also need to have a yaml file called \code{_gcssave.yaml} in the root of the directory.  It can hold the following arguments:

\itemize{
 \item [Required] \code{bucket} - the GCS bucket to save to
 \item [Optional] \code{loaddir} - if the folder name is different to the current, where to load the R session from
 \item [Optional] \code{pattern} - a regex of what files to save at the end of the session
 \item [Optional] \code{load_on_startup} - if \code{FALSE} will not attempt to load on startup
}

The bucket name is also set via the environment arg \code{GCE_SESSION_BUCKET}. The yaml bucket name will take precedence if both are set.

The folder is named on GCS the full working path to the working directory e.g. \code{/Users/mark/dev/your-r-project} which is what is looked for on startup.  If you create a new R project with the same filepath and bucket as an existing saved set, the files will download automatically when you load R from that folder (when starting an RStudio project).

If you load from a different filepath (e.g. with \code{loadir} set in yaml), when you exit and save the files will be saved under your new present working directory.

Files with the same name will not be overwritten.  If you want them to be, delete or rename them then reload the R session.

This function does not act like git, or intended as a replacement - its main use is imagined to be for using RStudio Server within disposable Docker containers on Google Cloud Engine (e.g. via \code{googleComputeEngineR})


For authentication for GCS,
 the easiest way is to make sure your authentication file is
 available in environment file \code{GCS_AUTH_FILE},
 or if on Google Compute Engine it will reuse the Google Cloud authentication
 via \link[googleAuthR]{gar_gce_auth}
}
\examples{

\dontrun{

.First <- function(){
  googleCloudStorageR::gcs_first()
}


.Last <- function(){
  googleCloudStorageR::gcs_last()
}


}

}
\seealso{
\link{gcs_save_all} and \link{gcs_load_all} that these functions call

\link{gcs_save_all} and \link{gcs_load_all} that these functions call
}
