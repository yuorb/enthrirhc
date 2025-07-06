import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vector_graphics/vector_graphics.dart';

import 'package:enthrirhc/components/list_group_title.dart';

class License extends StatelessWidget {
  final String name;
  final String link;
  final String license;

  const License({
    super.key,
    required this.name,
    required this.link,
    required this.license,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(name),
      subtitle: Text(
        "$link\n$license",
        style: TextStyle(
          fontSize: 12,
          color: Theme.of(
            context,
          ).textTheme.bodyMedium!.color!.withValues(alpha: 0.6),
        ),
      ),
      onTap: () =>
          launchUrl(Uri.parse(link), mode: LaunchMode.externalApplication),
    );
  }
}

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("About")),
      body: ListView(
        children: [
          const SizedBox(height: 18),
          const SvgPicture(
            AssetBytesLoader('assets/icons_compiled/logo.svg.vec'),
            width: 96,
          ),
          const SizedBox(height: 12),
          Text(
            "Enţrirç",
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          FutureBuilder<PackageInfo>(
            future: PackageInfo.fromPlatform(),
            builder:
                (BuildContext context, AsyncSnapshot<PackageInfo> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Text(
                      snapshot.hasError
                          ? "Error: ${snapshot.error}"
                          : "Version: ${snapshot.data!.version}",
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    );
                  } else {
                    return Container();
                  }
                },
          ),
          const ListGroupTitle("What's this"),
          Container(
            margin: const EdgeInsets.fromLTRB(16, 0, 16, 8),
            child: const Text("Enţrirç, an utility set for Ithkuil IV. "),
          ),
          const ListGroupTitle("Developers"),
          ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                "https://avatars.githubusercontent.com/u/21173956",
                width: 48,
              ),
            ),
            title: const Text("Lomirus"),
            subtitle: const Text("https://github.com/lomirus"),
            onTap: () => launchUrl(
              Uri.parse("https://github.com/lomirus"),
              mode: LaunchMode.externalApplication,
            ),
          ),
          const ListGroupTitle("Source Code"),
          ListTile(
            leading: SvgPicture(
              const AssetBytesLoader('assets/icons_compiled/github.svg.vec'),
              colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.onSurfaceVariant,
                BlendMode.srcIn,
              ),
            ),
            title: const Text("Github"),
            subtitle: const Text("https://github.com/yuorb/enthrirhc"),
            onTap: () => launchUrl(
              Uri.parse("https://github.com/yuorb/enthrirhc"),
              mode: LaunchMode.externalApplication,
            ),
          ),
          const ListGroupTitle("Open Source Licenses"),
          const License(
            name: "flutter - flutter",
            link: "https://github.com/flutter/flutter/blob/master/LICENSE",
            license: "BSD 3-Clause \"New\" or \"Revised\" License",
          ),
          const License(
            name: "packages - flutter",
            link: "https://github.com/flutter/packages/blob/main/LICENSE",
            license: "BSD 3-Clause \"New\" or \"Revised\" License",
          ),
          const License(
            name: "plus_plugins - fluttercommunity",
            link:
                "https://github.com/fluttercommunity/plus_plugins/blob/main/LICENSE",
            license: "BSD 3-Clause \"New\" or \"Revised\" License",
          ),
          const License(
            name: "path - dart-lang",
            link: "https://github.com/dart-lang/path/blob/master/LICENSE",
            license: "BSD 3-Clause \"New\" or \"Revised\" License",
          ),
          const License(
            name: "provider - rrousselGit",
            link: "https://github.com/rrousselGit/provider/blob/master/LICENSE",
            license: "MIT License",
          ),
          const License(
            name: "flutter_file_picker - miguelpruivo",
            link:
                "https://github.com/miguelpruivo/flutter_file_picker/blob/master/LICENSE",
            license: "MIT License",
          ),
          const License(
            name: "drift - simolus3",
            link: "https://github.com/simolus3/drift/blob/develop/LICENSE",
            license: "MIT License",
          ),
          const License(
            name: "sqlite3.dart - simolus3",
            link: "https://github.com/simolus3/sqlite3.dart/blob/main/LICENSE",
            license: "MIT License",
          ),
          const License(
            name: "flutter_svg - dnfield",
            link: "https://github.com/dnfield/flutter_svg/blob/master/LICENSE",
            license: "MIT License",
          ),
          const License(
            name: "simple-icons-website - simple-icons",
            link:
                "https://github.com/simple-icons/simple-icons-website/blob/master/LICENSE.md",
            license: "Creative Commons Zero v1.0 Universal",
          ),
        ],
      ),
    );
  }
}
