

locals {

}


inputs = {
  xlsx_data = slice(csvdecode(run_cmd("bash", "-c", "in2csv -I --sheet Networks ./config/networks.xlsx")), 0, 2)
}
