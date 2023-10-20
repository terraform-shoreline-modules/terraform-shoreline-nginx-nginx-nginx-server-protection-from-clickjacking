resource "shoreline_notebook" "nginx_server_protection_from_clickjacking" {
  name       = "nginx_server_protection_from_clickjacking"
  data       = file("${path.module}/data/nginx_server_protection_from_clickjacking.json")
  depends_on = [shoreline_action.invoke_add_x_frame_options_header,shoreline_action.invoke_set_csp_header_nginx_conf]
}

resource "shoreline_file" "add_x_frame_options_header" {
  name             = "add_x_frame_options_header"
  input_file       = "${path.module}/data/add_x_frame_options_header.sh"
  md5              = filemd5("${path.module}/data/add_x_frame_options_header.sh")
  description      = "Implement X-Frame-Options headers in the Nginx server configuration to prevent the server from being embedded in malicious web pages."
  destination_path = "/tmp/add_x_frame_options_header.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_file" "set_csp_header_nginx_conf" {
  name             = "set_csp_header_nginx_conf"
  input_file       = "${path.module}/data/set_csp_header_nginx_conf.sh"
  md5              = filemd5("${path.module}/data/set_csp_header_nginx_conf.sh")
  description      = "Use Content Security Policy (CSP) to restrict the types of content that can be loaded on the server, and to prevent the execution of malicious scripts."
  destination_path = "/tmp/set_csp_header_nginx_conf.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_add_x_frame_options_header" {
  name        = "invoke_add_x_frame_options_header"
  description = "Implement X-Frame-Options headers in the Nginx server configuration to prevent the server from being embedded in malicious web pages."
  command     = "`chmod +x /tmp/add_x_frame_options_header.sh && /tmp/add_x_frame_options_header.sh`"
  params      = ["X_FRAME_OPTIONS_VALUE","NGINX_CONFIG_FILE_PATH"]
  file_deps   = ["add_x_frame_options_header"]
  enabled     = true
  depends_on  = [shoreline_file.add_x_frame_options_header]
}

resource "shoreline_action" "invoke_set_csp_header_nginx_conf" {
  name        = "invoke_set_csp_header_nginx_conf"
  description = "Use Content Security Policy (CSP) to restrict the types of content that can be loaded on the server, and to prevent the execution of malicious scripts."
  command     = "`chmod +x /tmp/set_csp_header_nginx_conf.sh && /tmp/set_csp_header_nginx_conf.sh`"
  params      = []
  file_deps   = ["set_csp_header_nginx_conf"]
  enabled     = true
  depends_on  = [shoreline_file.set_csp_header_nginx_conf]
}

