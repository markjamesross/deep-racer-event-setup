#Create group for Deep racer participants
resource "aws_iam_group" "deep_racer_participants" {
  name = "deep_racer_participants"
  path = "/"
}
#Attach Deep Racer User Policy to Group
resource "aws_iam_group_policy_attachment" "deep_racer_participants" {
  group      = aws_iam_group.deep_racer_participants.name
  policy_arn = "arn:aws:iam::aws:policy/AWSDeepRacerDefaultMultiUserAccess"
}
#Attach IAM PAssword Policy to Group
resource "aws_iam_group_policy_attachment" "deep_racer_participants2" {
  group      = aws_iam_group.deep_racer_participants.name
  policy_arn = "arn:aws:iam::aws:policy/IAMUserChangePassword"
}
#Attach S3 IAM policy
resource "aws_iam_group_policy_attachment" "deep_racer_participants3" {
  group      = aws_iam_group.deep_racer_participants.name
  policy_arn = aws_iam_policy.s3_user.arn
}
#Create IAM user for each participant
resource "aws_iam_user" "deep_racer_participant" {
  for_each = var.deep_racer_participants
  name     = each.key
  path     = "/"

  tags = {
    Name = each.key
  }
}
#Add each user to group
resource "aws_iam_user_group_membership" "deep_racer_participant" {
  for_each = var.deep_racer_participants
  user     = aws_iam_user.deep_racer_participant[each.key].name

  groups = [
    aws_iam_group.deep_racer_participants.name,
  ]
}
#Create each user login profile
resource "aws_iam_user_login_profile" "deep_racer_participant" {
  for_each                = var.deep_racer_participants
  user                    = aws_iam_user.deep_racer_participant[each.key].name
  password_reset_required = true
  lifecycle {
    ignore_changes = [
      # Ignore changes to password to avoid recreating when users change them
      password_reset_required,
    ]
  }
}

#Create S3 permissions to limit a user to their own subfolder in S3
data "aws_iam_policy_document" "user_permissions" {
  statement {
    sid    = "AlowUserOwnFolder"
    effect = "Allow"
    actions = [
      "s3:*",
    ]
    resources = [
      "arn:aws:s3:::deepracer-models-${data.aws_caller_identity.current.account_id}/$${aws:username}",
      "arn:aws:s3:::deepracer-models-${data.aws_caller_identity.current.account_id}/$${aws:username}/*"
    ]
  }
  statement {
    sid    = "AlowUserListBucketAccess"
    effect = "Allow"
    actions = [
      "s3:ListBucket",
      "s3:ListAllMyBuckets"
    ]
    resources = [
      "*"
    ]
  }
}
#Create policy from above IAM policy document
resource "aws_iam_policy" "s3_user" {
  name        = "S3_user_access"
  path        = "/"
  description = "S3 user access"
  policy      = data.aws_iam_policy_document.user_permissions.json
}
#Add user and password to file
resource "null_resource" "users_passwords" {
  for_each = var.deep_racer_participants
  provisioner "local-exec" {
    interpreter = ["/bin/bash", "-c"]
    command     = <<EOF
echo "${each.key}, ${aws_iam_user_login_profile.deep_racer_participant[each.key].password}" >> users_and_passwords.csv
EOF
  }
}