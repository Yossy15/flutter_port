import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

enum Social { github, facebook, instagram, telephone, email }

IconData getSocialIcon(Social social) {
  switch (social) {
    case Social.github:
      return PhosphorIcons.githubLogo();
    case Social.facebook:
      return PhosphorIcons.facebookLogo();
    case Social.instagram:
      return PhosphorIcons.instagramLogo();
    case Social.telephone:
      return PhosphorIcons.phone();
    case Social.email:
      return PhosphorIcons.envelope();
  }
}
