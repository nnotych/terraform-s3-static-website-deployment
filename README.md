# terraform-s3-static-website-deployment

# Project Description

This project deploys a static website on AWS S3 using Terraform. Below is a brief description of each file and folder:

## Terraform Configuration Files

- **`main.tf`**
  - The main Terraform configuration file. Defines resources such as the S3 bucket, objects within it, and website configuration.

- **`outputs.tf`**
  - File for defining Terraform output variables. Provides information about created resources, such as the website URL.

- **`provider.tf`**
  - File for configuring the Terraform provider, in this case, AWS. Contains information about credentials and the region.

- **`variables.tf`**
  - File for defining variables that can be used in the Terraform configuration. Allows flexible configuration.

- **`terraform.tfstate`**
  - The Terraform state file. Contains information about the deployed resources. Should not be edited manually.

- **`terraform.tfstate.backup`**
  - Backup of the Terraform state file. Used for recovery in case of errors.

## Website Folder

- **`website/`**
  - Folder containing static files for the website. Files in this folder are uploaded to the S3 bucket and used for rendering the website.

  - **`index.html`**: The main page of the website.
  - **`error.html`**: Error page displayed in case of errors.
  - **`style/`**: Folder containing CSS files for styling the website.
    - **`style.css`**: CSS file for styling the website.
  - **`images/`**: Folder containing images for the website.
    - **`example1.png`**
    - **`example2.jpg`**
    - **`exampleiconlogo.ico`**
