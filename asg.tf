resource "aws_placement_group" "boss-placement-group" {
  name     = "boss-placement-group"
  strategy = "cluster"
}

resource "aws_autoscaling_policy" "boss-autoscalling-policy" {
  autoscaling_group_name = aws_autoscaling_group.boss-autoscalling-group.id
  name                   = "boss-autoscalling-policy"
  policy_type = "SimpleScaling"
  scaling_adjustment = "1"
  adjustment_type = "ChangeInCapacity"
  cooldown = "300"
}

resource "aws_launch_configuration" "boss-autoscalling-group" {
  name          = "boss-autoscalling-group"
  image_id      = data.aws_ami.amazon_linux_2.id
  instance_type = "t2.micro"
}

resource "aws_autoscaling_group" "boss-autoscalling-group" {
  name                      = "boss-autoscalling-group"
  max_size                  = 4
  min_size                  = 2
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = 4
  force_delete              = true
  placement_group           = aws_placement_group.boss-placement-group.id
  launch_configuration      = aws_launch_configuration.boss-autoscalling-group.id
  vpc_zone_identifier       = [aws_subnet.boss-privatesubnet1.id, aws_subnet.boss-privatesubnet2.id]

  initial_lifecycle_hook {
    name                 = "boss-lifecycle-hook"
    default_result       = "CONTINUE"
    heartbeat_timeout    = 2000
    lifecycle_transition = "autoscaling:EC2_INSTANCE_LAUNCHING"

    notification_metadata = <<EOF
{
  "foo": "bar"
}
EOF

    notification_target_arn = "arn:aws:sns:us-east-1:568170370118:jjtech-sns"
    role_arn                = "arn:aws:iam::568170370118:role/ansibleEC2access"
  }

  timeouts {
    delete = "15m"
  }
}