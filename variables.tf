#General Vars
variable "deployment_tool" {
  type        = string
  default     = "terraform"
  description = "Tool used to deploy code"
}
variable "service_name" {
  description = "Name of the service"
  type        = string
  default     = "Deep Racer"
}
variable "repository_name" {
  description = "Name of the GitHub Repository."
  type        = string
  default     = "deep-racer-event-setup"
}
variable "aws_region" {
  description = "Name of the AWS region to deploy to.  Deep Racer currently only supported in us-east-1"
  type        = string
  default     = "us-east-1"
}
#Variables for billing alerts
variable "billing_alert_price" {
  type        = list(any)
  description = "The limit alert for billing alerts"
  default     = ["1000", "2000", "3000", "4000", "5000"]
}
variable "billing_alert_unit" {
  type        = string
  description = "The unit of measurement for the budget forecast"
  default     = "USD"
}
variable "subscriber_email_addresses" {
  type        = list(any)
  description = "The email addresses to notify"
  default     = []
}
#Deep Racer Vars
variable "deep_racer_participants" {
  description = "List of Deep Racer Participant IAM users to create"
  type        = set(string)
  default = [

  ]
}