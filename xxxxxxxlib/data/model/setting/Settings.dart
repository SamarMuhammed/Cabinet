import 'dart:convert';
/// id : 2
/// name : "عن التطبيق"
/// eName : "About"
/// description : "<p class=MsoNormal dir=RTL style='margin-top:6.0pt;margin-right:0cm;margin-bottom:\r\n\r\n6.0pt;margin-left:0cm;text-align:justify;text-justify:kashida;text-kashida:\r\n\r\n0%;line-height:115%;direction:rtl;unicode-bidi:embed'><b><span lang=AR-EG\r\n\r\nstyle='font-size:14.0pt;line-height:115%;font-family:Tajawal;mso-bidi-language:\r\n\r\nAR-EG'>عن التطبيق<o:p></o:p></span></b></p>\r\n\r\n \r\n\r\n<p class=MsoNormal dir=RTL style='margin-top:6.0pt;margin-right:0cm;margin-bottom:\r\n\r\n6.0pt;margin-left:0cm;text-align:justify;text-justify:kashida;text-kashida:\r\n\r\n0%;line-height:115%;direction:rtl;unicode-bidi:embed'><span lang=AR-EG\r\n\r\nstyle='font-size:12.0pt;line-height:115%;font-family:Tajawal;mso-bidi-language:\r\n\r\nAR-EG'>يُتيح مركز المعلومات ودعم اتخاذ القرار من خلال التطبيق البيانات\r\n\r\nوالمعلومات المُحدّثة من مصادرها المتنوعة، ويتضمن 6 مكونات رئيسية:<o:p></o:p></span></p>\r\n\r\n \r\n\r\n<p class=MsoNormal dir=RTL style='margin-top:6.0pt;margin-right:0cm;margin-bottom:\r\n\r\n6.0pt;margin-left:0cm;text-align:justify;text-justify:kashida;text-kashida:\r\n\r\n0%;line-height:115%;direction:rtl;unicode-bidi:embed'><b><u><span lang=AR-EG\r\n\r\nstyle='font-size:12.0pt;line-height:115%;font-family:Tajawal;mso-bidi-language:\r\n\r\nAR-EG'><span style='mso-spacerun:yes'> </span>أخبار وآراء:</span></u></b><b><u><span\r\n\r\ndir=LTR style='font-size:12.0pt;line-height:115%;font-family:Tajawal;\r\n\r\nmso-bidi-language:AR-EG'><o:p></o:p></span></u></b></p>\r\n\r\n \r\n\r\n<p class=MsoNormal dir=RTL style='margin-top:6.0pt;margin-right:0cm;margin-bottom:\r\n\r\n6.0pt;margin-left:0cm;text-align:justify;text-justify:kashida;text-kashida:\r\n\r\n0%;line-height:115%;direction:rtl;unicode-bidi:embed'><span lang=AR-EG\r\n\r\nstyle='font-size:12.0pt;line-height:115%;font-family:Tajawal;mso-bidi-language:\r\n\r\nAR-EG'>عرض أهم الأخبار والأحداث المحلية والإقليمية والدولية، أهم القضايا على\r\n\r\nالساحة المحلية، مقالات الرأي والتقارير الدولية من مختلف المصادر العالمية. <o:p></o:p></span></p>\r\n\r\n \r\n\r\n<p class=MsoNormal dir=RTL style='margin-top:6.0pt;margin-right:0cm;margin-bottom:\r\n\r\n6.0pt;margin-left:0cm;text-align:justify;text-justify:kashida;text-kashida:\r\n\r\n0%;line-height:115%;direction:rtl;unicode-bidi:embed'><b><u><span lang=AR-EG\r\n\r\nstyle='font-size:12.0pt;line-height:115%;font-family:Tajawal;mso-bidi-language:\r\n\r\nAR-EG'>اتجاهات الأسواق: <o:p></o:p></span></u></b></p>\r\n\r\n \r\n\r\n<p class=MsoNormal dir=RTL style='margin-top:6.0pt;margin-right:0cm;margin-bottom:\r\n\r\n6.0pt;margin-left:0cm;text-align:justify;text-justify:kashida;text-kashida:\r\n\r\n0%;line-height:115%;direction:rtl;unicode-bidi:embed'><b><span lang=AR-EG\r\n\r\nstyle='font-size:12.0pt;line-height:115%;font-family:Tajawal;mso-bidi-language:\r\n\r\nAR-EG'>الأسعار اليومية لأهم السلع المحلية:</span></b><span lang=AR-EG\r\n\r\nstyle='font-size:12.0pt;line-height:115%;font-family:Tajawal;mso-bidi-language:\r\n\r\nAR-EG'> ونسب تغيرها اليومي والسنوي.<o:p></o:p></span></p>\r\n\r\n \r\n\r\n<p class=MsoNormal dir=RTL style='margin-top:6.0pt;margin-right:0cm;margin-bottom:\r\n\r\n6.0pt;margin-left:0cm;text-align:justify;text-justify:kashida;text-kashida:\r\n\r\n0%;line-height:115%;direction:rtl;unicode-bidi:embed'><b><span lang=AR-EG\r\n\r\nstyle='font-size:12.0pt;line-height:115%;font-family:Tajawal;mso-bidi-language:\r\n\r\nAR-EG'><span style='mso-spacerun:yes'> </span>أسعار السلع العالمية:</span></b><span\r\n\r\nlang=AR-EG style='font-size:12.0pt;line-height:115%;font-family:Tajawal;\r\n\r\nmso-bidi-language:AR-EG'> كالبترول والحاصلات الزراعية والمعادن والعديد من السلع\r\n\r\nالأخرى.<b> <o:p></o:p></b></span></p>\r\n\r\n \r\n\r\n<p class=MsoNormal dir=RTL style='margin-top:6.0pt;margin-right:0cm;margin-bottom:\r\n\r\n6.0pt;margin-left:0cm;text-align:justify;text-justify:kashida;text-kashida:\r\n\r\n0%;line-height:115%;direction:rtl;unicode-bidi:embed'><b><span lang=AR-EG\r\n\r\nstyle='font-size:12.0pt;line-height:115%;font-family:Tajawal;mso-bidi-language:\r\n\r\nAR-EG'>أسواق المال:</span></b><span lang=AR-EG style='font-size:12.0pt;\r\n\r\nline-height:115%;font-family:Tajawal;mso-bidi-language:AR-EG'> أهم مؤشرات حركة\r\n\r\nالبورصات المحلية والعالمية، وشهادات الإيداع الدولية.<o:p></o:p></span></p>\r\n\r\n \r\n\r\n<p class=MsoNormal dir=RTL style='margin-top:6.0pt;margin-right:0cm;margin-bottom:\r\n\r\n6.0pt;margin-left:0cm;text-align:justify;text-justify:kashida;text-kashida:\r\n\r\n0%;line-height:115%;direction:rtl;unicode-bidi:embed'><b><span lang=AR-EG\r\n\r\nstyle='font-size:12.0pt;line-height:115%;font-family:Tajawal;mso-bidi-language:\r\n\r\nAR-EG'>أسواق النقد</span></b><span lang=AR-EG style='font-size:12.0pt;\r\n\r\nline-height:115%;font-family:Tajawal;mso-bidi-language:AR-EG'>: سعر صرف الجنيه\r\n\r\nالمصري، وأسعار صرف العملات المختلفة، والعائد على الإقرا<a name=\"_GoBack\"></a>ض\r\n\r\nبين البنوك، ومعدلات الفائدة<o:p></o:p></span></p>\r\n\r\n \r\n\r\n<p class=MsoNormal dir=RTL style='margin-top:6.0pt;margin-right:0cm;margin-bottom:\r\n\r\n6.0pt;margin-left:0cm;text-align:justify;text-justify:kashida;text-kashida:\r\n\r\n0%;line-height:115%;direction:rtl;unicode-bidi:embed'><b><u><span lang=AR-EG\r\n\r\nstyle='font-size:12.0pt;line-height:115%;font-family:Tajawal;mso-bidi-language:\r\n\r\nAR-EG'>مؤشرات محلية<o:p></o:p></span></u></b></p>\r\n\r\n \r\n\r\n<p class=MsoNormal dir=RTL style='margin-top:6.0pt;margin-right:0cm;margin-bottom:\r\n\r\n6.0pt;margin-left:0cm;text-align:justify;text-justify:kashida;text-kashida:\r\n\r\n0%;line-height:115%;direction:rtl;unicode-bidi:embed'><span lang=AR-EG\r\n\r\nstyle='font-size:12.0pt;line-height:115%;font-family:Tajawal;mso-bidi-language:\r\n\r\nAR-EG'>يعرض مؤشرات أبرزها الموازنة العامة للدولة، والتضخم، والاستثمار، والناتج\r\n\r\nالمحلي الإجمالي، والبيانات النقدية، والسكان والزيادة الطبيعية، وعرض تطورها لمدة\r\n\r\nزمنية تفوق الـ 10 سنوات. <o:p></o:p></span></p>\r\n\r\n \r\n\r\n<p class=MsoNormal dir=RTL style='margin-top:6.0pt;margin-right:0cm;margin-bottom:\r\n\r\n6.0pt;margin-left:0cm;text-align:justify;text-justify:kashida;text-kashida:\r\n\r\n0%;line-height:115%;direction:rtl;unicode-bidi:embed'><b><u><span lang=AR-EG\r\n\r\nstyle='font-size:12.0pt;line-height:115%;font-family:Tajawal;mso-bidi-language:\r\n\r\nAR-EG'><span style='mso-spacerun:yes'> </span>مؤشرات دولية<o:p></o:p></span></u></b></p>\r\n\r\n \r\n\r\n<p class=MsoNormal dir=RTL style='margin-top:6.0pt;margin-right:0cm;margin-bottom:\r\n\r\n6.0pt;margin-left:0cm;text-align:justify;text-justify:kashida;text-kashida:\r\n\r\n0%;line-height:115%;direction:rtl;unicode-bidi:embed'><span lang=AR-EG\r\n\r\nstyle='font-size:12.0pt;line-height:115%;font-family:Tajawal;mso-bidi-language:\r\n\r\nAR-EG'>يعرض وضع مصر في المؤشرات الدولية ليغطي ما يفوق الـ 50 مؤشر دولي، مثل\r\n\r\nبيئة الأعمال، الحريات العامة وغيرها.<o:p></o:p></span></p>\r\n\r\n \r\n\r\n<p class=MsoNormal dir=RTL style='margin-top:6.0pt;margin-right:0cm;margin-bottom:\r\n\r\n6.0pt;margin-left:0cm;text-align:justify;text-justify:kashida;text-kashida:\r\n\r\n0%;line-height:115%;direction:rtl;unicode-bidi:embed'><b><u><span lang=AR-EG\r\n\r\nstyle='font-size:12.0pt;line-height:115%;font-family:Tajawal;mso-bidi-language:\r\n\r\nAR-EG'>إصدارات وتقارير<o:p></o:p></span></u></b></p>\r\n\r\n \r\n\r\n<p class=MsoNormal dir=RTL style='margin-top:6.0pt;margin-right:0cm;margin-bottom:\r\n\r\n6.0pt;margin-left:0cm;text-align:justify;text-justify:kashida;text-kashida:\r\n\r\n0%;line-height:115%;direction:rtl;unicode-bidi:embed'><span lang=AR-EG\r\n\r\nstyle='font-size:12.0pt;line-height:115%;font-family:Tajawal;mso-bidi-language:\r\n\r\nAR-EG'>يُتيح أهم إصدارات وتقارير المركز البحثية التي تُقّدم تحليلا لموضوعات\r\n\r\nمتنوعة، وعروض الكتب، والمفاهيم التنموية، والخبرات والتجارب الدولية.<o:p></o:p></span></p>\r\n\r\n \r\n\r\n<p class=MsoNormal dir=RTL style='margin-top:6.0pt;margin-right:0cm;margin-bottom:\r\n\r\n6.0pt;margin-left:0cm;text-align:justify;text-justify:kashida;text-kashida:\r\n\r\n0%;line-height:115%;direction:rtl;unicode-bidi:embed'><b><u><span lang=AR-EG\r\n\r\nstyle='font-size:12.0pt;line-height:115%;font-family:Tajawal;mso-bidi-language:\r\n\r\nAR-EG'>وسائط مُتعددة</span></u></b><b><u><span dir=LTR style='font-size:12.0pt;\r\n\r\nline-height:115%;font-family:Tajawal;mso-bidi-language:AR-EG'><o:p></o:p></span></u></b></p>\r\n\r\n \r\n\r\n<p class=MsoNormal dir=RTL style='margin-top:6.0pt;margin-right:0cm;margin-bottom:\r\n\r\n6.0pt;margin-left:0cm;text-align:justify;text-justify:kashida;text-kashida:\r\n\r\n0%;line-height:115%;direction:rtl;unicode-bidi:embed'><span lang=AR-EG\r\n\r\nstyle='font-size:12.0pt;line-height:115%;font-family:Tajawal;mso-bidi-language:\r\n\r\nAR-EG'>يعرض إصدارات المركز من <span class=SpellE>الإنفوجراف</span> <span\r\n\r\nclass=SpellE>والفيديوجراف</span> <span class=SpellE>والبودكاست</span>.<b><u><o:p></o:p></u></b></span></p>\r\n\r\n \r\n\r\n<p class=MsoNormal dir=RTL style='margin-top:6.0pt;margin-right:0cm;margin-bottom:\r\n\r\n6.0pt;margin-left:0cm;text-align:justify;text-justify:kashida;text-kashida:\r\n\r\n0%;line-height:115%;direction:rtl;unicode-bidi:embed'><b><u><span lang=AR-EG\r\n\r\nstyle='font-size:12.0pt;line-height:115%;font-family:Tajawal;mso-bidi-language:\r\n\r\nAR-EG'><o:p><span style='text-decoration:none'>&nbsp;</span></o:p></span></u></b></p>\r\n\r\n \r\n\r\n<p class=MsoNormal dir=RTL style='margin-top:6.0pt;margin-right:0cm;margin-bottom:\r\n\r\n6.0pt;margin-left:0cm;text-align:justify;text-justify:kashida;text-kashida:\r\n\r\n0%;line-height:115%;direction:rtl;unicode-bidi:embed'><b><u><span dir=LTR\r\n\r\nstyle='font-size:12.0pt;line-height:115%;font-family:Tajawal;mso-bidi-language:\r\n\r\nAR-EG'><o:p><span style='text-decoration:none'>&nbsp;</span></o:p></span></u></b></p> "
/// type : "Button"

Settings settingsNameFromJson(String str) => Settings.fromJson(json.decode(str));
String settingsNameToJson(Settings data) => json.encode(data.toJson());
class Settings {
  Settings({

    String? name,
    String? eName,
    String? description,
    String? type,}){

    _name = name;
    _eName = eName;
    _description = description;
    _type = type;
  }

  Settings.fromJson(dynamic json) {

    _name = json['name'];
    _eName = json['eName'];
    _description = json['description'];
    _type = json['type'];
  }

  String? _name;
  String? _eName;
  String? _description;
  String? _type;


  String? get name => _name;
  String? get eName => _eName;
  String? get description => _description;
  String? get type => _type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};

    map['name'] = _name;
    map['eName'] = _eName;
    map['description'] = _description;
    map['type'] = _type;
    return map;
  }

}