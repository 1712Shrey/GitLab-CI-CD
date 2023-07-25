resource "aws_autoscaling_group" "asg" {
  name                      = var.asg-name
  max_size                  = var.max-size
  min_size                  = var.min-size
  health_check_type        = var.health_check_type
  desired_capacity          = var.desired
  vpc_zone_identifier       = var.public-subnet-id

  launch_template {
    id      = aws_launch_template.foobar.id
    version = "$Latest"
  }
  
}

resource "aws_autoscaling_policy" "example" {
  autoscaling_group_name = aws_autoscaling_group.asg.name
  name                   = var.policy-name
  policy_type            = var.policy_type
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }

    target_value = var.target_value
  }
}

# resource "aws_autoscaling_attachment" "example" {
#   autoscaling_group_name = aws_autoscaling_group.asg.name
#   elb                    = var.lb-id
# }

resource "aws_autoscaling_attachment" "example" {
  autoscaling_group_name = aws_autoscaling_group.asg.name
  lb_target_group_arn    = var.tg-arn
}

resource "aws_launch_template" "foobar" {
  name_prefix   = "foobar"
  image_id      = var.ami-id
  instance_type = "t2.micro"
}