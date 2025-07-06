import 'package:enthrirhc/libs/misc.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vector_graphics/vector_graphics.dart';

import 'package:enthrirhc/components/list_group_title.dart';

class CommunityTile extends StatelessWidget {
  const CommunityTile({
    required this.name,
    this.link,
    this.code,
    this.icon,
    super.key,
  });

  final String name;
  final String? link;
  final String? code;
  final String? icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon != null
          ? SvgPicture(
              AssetBytesLoader('assets/icons_compiled/$icon.svg.vec'),
              colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.onSurfaceVariant,
                BlendMode.srcIn,
              ),
            )
          : const Icon(Icons.article),
      title: Text(name),
      subtitle: Text(
        link ?? code!,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant),
      ),
      trailing: code != null
          ? IconButton(
              onPressed: () => copyToClipboard(code!, context),
              icon: const Icon(Icons.copy),
            )
          : null,
      onTap: link != null
          ? () => launchUrl(
              Uri.parse(link!),
              mode: LaunchMode.externalApplication,
            )
          : null,
    );
  }
}

class CommunitiesPage extends StatefulWidget {
  const CommunitiesPage({super.key});

  @override
  State<CommunitiesPage> createState() => _CommunitiesPageState();
}

class _CommunitiesPageState extends State<CommunitiesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Communities")),
      body: ListView(
        children: const [
          ListGroupTitle("English"),
          CommunityTile(
            name: "Discord",
            link: "https://discord.com/invite/WgFrX8J",
            icon: "discord",
          ),
          CommunityTile(
            name: "Reddit",
            link: "https://www.reddit.com/r/Ithkuil/",
            icon: "reddit",
          ),
          CommunityTile(
            name: "Official Website",
            link: "http://ithkuil.net/",
            icon: null,
          ),
          ListGroupTitle("Chinese"),
          CommunityTile(name: "QQ", code: "865538600", icon: "tencentqq"),
          CommunityTile(
            name: "Telegram",
            link: "https://t.me/ithkuil_cn",
            icon: "telegram",
          ),
          CommunityTile(
            name: "Github",
            link: "https://github.com/yuorb/",
            icon: "github",
          ),
          CommunityTile(
            name: "Official Website",
            link: "https://yuorb.github.io/",
            icon: null,
          ),
        ],
      ),
    );
  }
}
