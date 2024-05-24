variable "aws_key_pub" {
  description = "Chave public para a maquina da AWS"
  type        = string
}

variable "azure_key_pub" {
  description = "Chave public para a maquina da Azure"
  type        = string
}

variable "location" {
  description = "Região onde serão criados os recursos na Azure"
  type        = string
  default     = "East US"
}