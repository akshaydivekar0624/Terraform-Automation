terraform {
  backend "s3" {
    bucket = "ad-young-minds-app-project-terraform-state"
    key = "AD_Linux_Server_Key"
    region = "us-east-1"
    dynamodb_table = "my-dynamodb-table"
  }
}
