import 'package:flutter/widgets.dart';

import '../../libs/ithkuil/mod.dart';
import '../../libs/ithkuil/terms/mod.dart';

class ConstructPageRoots with ChangeNotifier {
  List<Formative> formatives = [];

  ConstructPageRoots();

  void push(Root root) {
    // Check `root` validation
    formatives.add(Formative(
      stem: Stem.s1,
      root: root,
      specification: Specification.bsc,
      context: Context.exs,
      function: Function$.sta,
      formativeType: const Standalone(Noun(Case.thm)),
      version: Version.prc,
      affiliation: Affiliation.csl,
      configuration: Configuration.from(Plexity.u, null, null)!,
      extension: Extension.del,
      perspective: Perspective.m,
      essence: Essence.nrm,
      csVxAffixes: [],
      vxCsAffixes: [],
      vnCn: VnCn(
        vn: const ValenceVn(Valence.mno),
        cn: Cn.cn1,
      ),
    ));
    notifyListeners();
  }

  void removeAt(int index) {
    formatives.removeAt(index);
    notifyListeners();
  }

  void updateFormative(int index, void Function(Formative) callback) {
    callback(formatives[index]);
    notifyListeners();
  }
}
