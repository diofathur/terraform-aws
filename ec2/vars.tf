data "template_file" "startup" {
  template = file("pritunl.sh")
}