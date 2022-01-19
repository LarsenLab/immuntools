#' @name allotope_human
#' @title Function of human peptide prediction.
#' @param don_ag donor antigens.
#' @param self_ag self antigens.
#' @param present_ag presenting alleles.
#' @param seq_len sequence length.
#' @param out_name name and path of html report.
#' @return
#' an html report
#' @export
#' allotope_human
#' @import
#' rmarkdown
#' @examples
#' \dontrun{
#' allotope_human(don_ag = c("DQB1_05_01", "DQB1_06_02"),
#' self_ag = c("DQB1_03_01", "DQB1_03_01"),
#' present_ag = c("DRB1_08_03", "DRB1_04_01"),
#' seq_len = '15',
#' out_name = '~/projects/allotope_report.html')
#' }

allotope_human <- function(don_ag = c("DQB1_05_01", "DQB1_06_02"),
                           self_ag = c("DQB1_03_01", "DQB1_03_01"),
                           present_ag = c("DRB1_08_03", "DRB1_04_01"),
                           seq_len = '15',
                           out_name = 'allotope_report.html')
{
  render(paste(path.package("immuntools"),"rmarkdown/templates/report/allotope/allotopeHuman.Rmd",sep = "/"),
                    params = list(donor_ag = don_ag,
                                  self_ag = self_ag,
                                  presenting_allele = present_ag,
                                  seq_len = seq_len),
                    output_file = out_name)
}


