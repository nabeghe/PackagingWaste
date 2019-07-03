public static void pwShowMessageDialog(String text) {
  javax.swing.JOptionPane.showMessageDialog(null, text);
}

public static void pwShowConfirmDialog() {
  javax.swing.JOptionPane pane = new javax.swing.JOptionPane();
  int response = pane.showConfirmDialog(null, "Are you sure you want to quit?");
}

public static String pwSplitCamelCase(String str) {
  String output = "";
  for (String word : str.split("(?<!(^|[A-Z]))(?=[A-Z])|(?<!^)(?=[A-Z][a-z])")) {
    output += word + " ";
  }
  return output.trim();
}

public void injectWestOperToView(PW_WestOper westOper, FK_ArcProgressView view) {
  view.clearArcs();
  view.addArc(new FK_ArcProgressObject(westOper.generated(), PW_VIS_GENERATED_COLOR));
  view.addArc(new FK_ArcProgressObject(westOper.recovery(), PW_VIS_RECYCLING_COLOR));
  view.addArc(new FK_ArcProgressObject(westOper.recycling(), PW_VIS_RECOVERY_COLOR));
}

public void injectWasteToView(PW_Waste waste, FK_TriangularMountainProgress view) {
  view.clearTriangles();
  view.addTriangle(new FK_TriangleMountain(waste.paperAndCardboard(), #0c3e65, "data/images/triangels/paper.png"));
  view.addTriangle(new FK_TriangleMountain(waste.plastic(), #650925, "data/images/triangels/plastic.png"));
  view.addTriangle(new FK_TriangleMountain(waste.wooden(), #b24725, "data/images/triangels/wooden.png"));
  view.addTriangle(new FK_TriangleMountain(waste.metallic(), #84c64e, "data/images/triangels/metallic.png"));
  view.addTriangle(new FK_TriangleMountain(waste.aluminium(), #cce3f3, "data/images/triangels/aluminium.png"));
  view.addTriangle(new FK_TriangleMountain(waste.steel(), #7857a5, "data/images/triangels/steel.png"));
  view.addTriangle(new FK_TriangleMountain(waste.glass(), #4fbec3, "data/images/triangels/glass.png"));
  // view.addTriangle(new FK_TriangleMountain(waste.other(), #cbff4d, "data/images/triangels/paper.png"));
}
