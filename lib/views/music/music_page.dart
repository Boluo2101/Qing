// Tools
import 'dart:async';
import 'package:flutter/material.dart';
import '../../tools/custom_colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../tools/color_extractor.dart';
import 'package:just_audio/just_audio.dart';

// Routers
import 'package:go_router/go_router.dart';

class MusicPage extends ConsumerStatefulWidget {
  const MusicPage({super.key});

  @override
  ConsumerState<MusicPage> createState() => _MusicPageState();
}

class _MusicPageState extends ConsumerState<MusicPage> {
  final List<Map<String, dynamic>> musicList = [
    {
      'title': '我们活着',
      'key': '1',
      'minutes': 249,
      'author': '刘牧',
      'cover': 'https://zcy-1251113349.file.myqcloud.com/testFiles/ll.png',
      'audio': 'https://zcy-1251113349.file.myqcloud.com/testFiles/lyy.mp3',
      'mainColor': Colors.yellow,
      'favorite': false,
      "lyrics": [
        ["当世界面对死亡", 'Dang shi jie mian dui si wang'],
        ["灵魂点燃了微光", 'Ling hun dian ran le wei guang'],
        ["那是救赎者的妄想", 'Na shi jiu shu zhe de wang xiang'],
        ["是末日冰冷的悲伤", 'Shi mo ri bing leng de bei shang'],
        ["当我们面对死亡", 'Dang wo men mian dui si wang'],
        ["我轻轻吻你的额头", 'Wo qing qing wen ni de e tou'],
        ["温热的脸庞", 'Wen re de lian pang'],
        ["闪烁着的眼眶", 'Shan shuo zhe de yan kuang'],
        ["这 至暗的夜", 'Zhe zhi an de ye'],
        ["再度被唤起的向往", 'Zai du bei huan qi de xiang wang'],
        ["无法阻挡", 'Wu fa zu dang'],
        ["不顾一切", 'Bu gu yi qie'],
        ["去疯狂", 'Qu feng kuang'],
        ["我们活着", 'Wo men huo zhe'],
        ["告诉每一个人", 'Gao su mei yi ge ren'],
        ["生命是多么不可想象", 'Sheng ming shi duo me bu ke xiang xiang'],
        ["深藏着无尽顽强", 'Shen cang zhe wu jin wan qiang'],
        ["在那一刻", 'Zai na yi ke'],
        ["你我站在宇宙的中心", 'Ni wo zhan zai yu zhou de zhong xin'],
        ["在那一刻", 'Zai na yi ke'],
        ["我们忘了", 'Wo men wang le'],
        ["抵抗", 'Di kang'],
      ],
    },
    {
      'title': '光辉岁月',
      'key': '2',
      'minutes': 349,
      'author': 'Beyond',
      'cover': 'https://zcy-1251113349.file.myqcloud.com/testFiles/by.webp',
      'audio': 'https://zcy-1251113349.file.myqcloud.com/testFiles/ghsy.mp3',
      'favorite': false,
      "lyrics": [
        ["钟声响起归家的讯号", "zung sang hoeng hei gwai gaa dik seon hou"],
        ["在他生命里", "zoi ta sang ming leoi"],
        ["仿佛带点唏嘘", "fong fat daai dim hei heoi"],
        ["黑色肌肤给他的意义", "hak sik gei fu kap ta dik ji ji"],
        ["是一生奉献 肤色斗争中", "si jat sang fung hin fuk sik dau zang zung"],
        ["年月把拥有变做失去", "nin jyut baa jung jau bin zou sat heoi"],
        ["疲倦的双眼带着期望", "pei jyun dik soeng ngaan daai zhe kei mong"],
        ["今天只有残留的躯壳", "gan tin zhi jau caan lau dik keoi hok"],
        ["迎接光辉岁月", "jing zip gwong fai seoi jyut"],
        ["风雨中抱紧自由", "fung jyu zung bou gan zi jau"],
        ["一生经过彷徨的挣扎", "jat sang ging gwo pong wong dik zang za"],
        ["自信可改变未来", "zi seon ho goi bin mei loi"],
        ["问谁又能做到", "man seoi jau nang zou dou"],
        ["", ""],
        ["可否不分肤色的界限", "ho fau bat fan fuk sik dik gaai haan"],
        ["愿这土地里", "jyun ze tou dei leoi"],
        ["不分你我高低", "bat fan nei ngo gou dai"],
        ["缤纷色彩闪出的美丽", "ban fan sik coi sin ceot dik mei lai"],
        ["是因它没有", "si jan ta mut jau"],
        ["分开每种色彩", "fan hoi mui zung sik coi"],
        ["年月把拥有变做失去", "nin jyut baa jung jau bin zou sat heoi"],
        ["疲倦的双眼带着期望", "pei jyun dik soeng ngaan daai zhe kei mong"],
        ["今天只有残留的躯壳", "gan tin zhi jau caan lau dik keoi hok"],
        ["迎接光辉岁月", "jing zip gwong fai seoi jyut"],
        ["风雨中抱紧自由", "fung jyu zung bou gan zi jau"],
        ["一生经过彷徨的挣扎", "jat sang ging gwo pong wong dik zang za"],
        ["自信可改变未来", "zi seon ho goi bin mei loi"],
        ["问谁又能做到", "man seoi jau nang zou dou"],
        ["", ""],
        ["今天只有残留的躯壳", "gan tin zhi jau caan lau dik keoi hok"],
        ["迎接光辉岁月", "jing zip gwong fai seoi jyut"],
        ["风雨中抱紧自由", "fung jyu zung bou gan zi jau"],
        ["一生经过彷徨的挣扎", "jat sang ging gwo pong wong dik zang za"],
        ["自信可改变未来", "zi seon ho goi bin mei loi"],
        ["问谁又能做到", "man seoi jau nang zou dou"],
        ["", ""],
        ["", ""],
        ["今天只有残留的躯壳", "gan tin zhi jau caan lau dik keoi hok"],
        ["迎接光辉岁月", "jing zip gwong fai seoi jyut"],
        ["风雨中抱紧自由", "fung jyu zung bou gan zi jau"],
        ["一生经过彷徨的挣扎", "jat sang ging gwo pong wong dik zang za"],
        ["自信可改变未来", "zi seon ho goi bin mei loi"],
        ["问谁又能做到", "man seoi jau nang zou dou"],
      ],
    },
    {
      'title': '海阔天空',
      'key': '3',
      'minutes': 239,
      'author': 'Beyond',
      'cover': 'https://testingbot.com/free-online-tools/random-avatar/900',
      'audio': 'https://zcy-1251113349.file.myqcloud.com/testFiles/lyy.mp3',
      'favorite': false,
      "lyrics": [
        ["今天我 寒夜里看雪飘过", "Jin tian wo han ye li kan xue piao guo"],
        ["怀着冷却了的心窝飘远方", "Huai zhe leng que le de xin wo piao yuan fang"],
        ["风雨里追赶 雾里分不清影踪", "Feng yu li zhui gan wu li fen bu qing ying zong"],
        [
          "天空海阔你与我 可会变（谁没在变）",
          "Tian kong hai kuo ni yu wo ke hui bian (shui mei zai bian)",
        ],
        ["", ""],
        ["多少次 迎着冷眼与嘲笑", "Duo shao ci ying zhe leng yan yu chao xiao"],
        ["从没有放弃过心中的理想", "Cong mei you fang qi guo xin zhong de li xiang"],
        ["一刹那恍惚 若有所失的感觉", "Yi cha na huang hu ruo you suo shi de gan jue"],
        [
          "不知不觉已变淡 心里爱（谁明白我）",
          "Bu zhi bu jue yi bian dan xin li ai (shui ming bai wo)",
        ],
        ["", ""],
        [
          "原谅我这一生不羁放纵爱自由",
          "Yuan liang wo zhe yi sheng bu ji fang zong ai zi you",
        ],
        ["也会怕有一天会跌倒", "Ye hui pa you yi tian hui die dao"],
        ["背弃了理想 谁人都可以", "Bei qi le li xiang shui ren dou ke yi"],
        ["哪会怕有一天只你共我", "Na hui pa you yi tian zhi ni gong wo"],
        ["", ""],
        ["今天我 寒夜里看雪飘过", "Jin tian wo han ye li kan xue piao guo"],
        ["怀着冷却了的心窝飘远方", "Huai zhe leng que le de xin wo piao yuan fang"],
        ["风雨里追赶 雾里分不清影踪", "Feng yu li zhui gan wu li fen bu qing ying zong"],
        [
          "天空海阔你与我 可会变（谁没在变）",
          "Tian kong hai kuo ni yu wo ke hui bian (shui mei zai bian)",
        ],
        ["", ""],
        [
          "原谅我这一生不羁放纵爱自由",
          "Yuan liang wo zhe yi sheng bu ji fang zong ai zi you",
        ],
        ["也会怕有一天会跌倒", "Ye hui pa you yi tian hui die dao"],
        ["背弃了理想 谁人都可以", "Bei qi le li xiang shui ren dou ke yi"],
        ["哪会怕有一天只你共我", "Na hui pa you yi tian zhi ni gong wo"],
        ["", ""],
        ["仍然自由自我 永远高唱我歌", "Reng ran zi you zi wo yong yuan gao chang wo ge"],
        ["走遍千里", "Zou bian qian li"],
        ["", ""],
        [
          "原谅我这一生不羁放纵爱自由",
          "Yuan liang wo zhe yi sheng bu ji fang zong ai zi you",
        ],
        ["也会怕有一天会跌倒", "Ye hui pa you yi tian hui die dao"],
        ["背弃了理想 谁人都可以", "Bei qi le li xiang shui ren dou ke yi"],
        ["哪会怕有一天只你共我", "Na hui pa you yi tian zhi ni gong wo"],
        ["", ""],
        ["背弃了理想 谁人都可以", "Bei qi le li xiang shui ren dou ke yi"],
        ["哪会怕有一天只你共我", "Na hui pa you yi tian zhi ni gong wo"],
        ["", ""],
        [
          "原谅我这一生不羁放纵爱自由",
          "Yuan liang wo zhe yi sheng bu ji fang zong ai zi you",
        ],
        ["也会怕有一天会跌倒", "Ye hui pa you yi tian hui die dao"],
        ["背弃了理想 谁人都可以", "Bei qi le li xiang shui ren dou ke yi"],
        ["哪会怕有一天只你共我", "Na hui pa you yi tian zhi ni gong wo"],
      ],
    },
    {
      'title': '喜欢你',
      'key': '4',
      'minutes': 229,
      'author': 'Beyond',
      'cover': 'https://testingbot.com/free-online-tools/random-avatar/700',
      'audio': 'https://zcy-1251113349.file.myqcloud.com/testFiles/ghsy.mp3',
      'favorite': false,
      "lyrics": [
        ["细雨带风湿透黄昏的街道", "xì yǔ dài fēng shī tòu huáng hūn de jiē dào"],
        ["抹去雨水双眼无故地仰望", "mǒ qù yǔ shuǐ shuāng yǎn wú gù de yǎng wàng"],
        ["望向孤单的晚灯", "wàng xiàng gū dān de wǎn dēng"],
        ["是那伤感的记忆", "shì nà shāng gǎn de jì yì"],
        ["再次泛起心里无数的思念", "zài cì fàn qǐ xīn lǐ wú shù de sī niàn"],
        ["以往片刻欢笑仍挂在脸上", "yǐ wǎng piàn kè huān xiào réng guà zài liǎn shàng"],
        ["愿你此刻可会知", "yuàn nǐ cǐ kè kě huì zhī"],
        ["是我衷心的说声", "shì wǒ zhōng xīn de shuō shēng"],
        ["", ""],
        ["喜欢你", "xǐ huān nǐ"],
        ["那双眼动人", "nà shuāng yǎn dòng rén"],
        ["笑声更迷人", "xiào shēng gèng mí rén"],
        ["愿再可 轻抚你", "yuàn zài kě qīng fǔ nǐ"],
        ["那可爱面容", "nà kě ài miàn róng"],
        ["挽手说梦话", "wǎn shǒu shuō mèng huà"],
        ["像昨天 你共我", "xiàng zuó tiān nǐ gòng wǒ"],
        ["", ""],
        ["满带理想的我曾经多冲动", "mǎn dài lǐ xiǎng de wǒ céng jīng duō chōng dòng"],
        ["你怨与她相爱难有自由", "nǐ yuàn yǔ tā xiāng ài nán yǒu zì yóu"],
        ["愿你此刻可会知", "yuàn nǐ cǐ kè kě huì zhī"],
        ["是我衷心的说声", "shì wǒ zhōng xīn de shuō shēng"],
        ["", ""],
        ["喜欢你", "xǐ huān nǐ"],
        ["那双眼动人", "nà shuāng yǎn dòng rén"],
        ["笑声更迷人", "xiào shēng gèng mí rén"],
        ["愿再可 轻抚你", "yuàn zài kě qīng fǔ nǐ"],
        ["那可爱面容", "nà kě ài miàn róng"],
        ["挽手说梦话", "wǎn shǒu shuō mèng huà"],
        ["像昨天 你共我", "xiàng zuó tiān nǐ gòng wǒ"],
        ["", ""],
        ["每晚夜里自我独行", "měi wǎn yè lǐ zì wǒ dú xíng"],
        ["随处荡 多冰冷", "suí chǔ dàng duō bīng lěng"],
        ["已往为了自我挣扎", "yǐ wǎng wèi le zì wǒ zhēng zhá"],
        ["从不知 她的痛苦", "cóng bù zhī tā de tòng kǔ"],
        ["", ""],
        ["喜欢你", "xǐ huān nǐ"],
        ["那双眼动人", "nà shuāng yǎn dòng rén"],
        ["笑声更迷人", "xiào shēng gèng mí rén"],
        ["愿再可 轻抚你", "yuàn zài kě qīng fǔ nǐ"],
        ["那可爱面容", "nà kě ài miàn róng"],
        ["挽手说梦话", "wǎn shǒu shuō mèng huà"],
        ["像昨天 你共我", "xiàng zuó tiān nǐ gòng wǒ"],
      ],
    },
  ];

  String keyActive = '1'; // 当前激活的音乐key
  Map<String, dynamic> musicActive = {
    'title': '我们活着',
    'key': '1',
    'minutes': 209,
    'author': '刘牧',
    'cover': 'https://testingbot.com/free-online-tools/random-avatar/400',
    'audio': 'https://zcy-1251113349.file.myqcloud.com/testFiles/lyy.mp3',
    'favorite': false,
    "lyrics": [
      "当世界面对死亡",
      "灵魂点燃了微光",
      "那是救赎者的妄想",
      "是末日冰冷的悲伤",
      "当我们面对死亡",
      "我轻轻吻你的额头",
      "温热的脸庞",
      "闪烁着的眼眶",
      "这 至暗的夜",
      "再度被唤起的向往",
      "无法阻挡",
      "不顾一切",
      "去疯狂",
      "我们活着",
      "告诉每一个人",
      "生命是多么不可想象",
      "深藏着无尽顽强",
      "在那一刻",
      "你我站在宇宙的中心",
      "在那一刻",
      "我们忘了",
      "抵抗",
    ],
  }; // 当前激活的音乐
  Color mainColor = CustomColors.getColorByStr('yellow');
  bool playing = false; // 是否播放中
  String totalMinutes = '0:00'; // 总时长
  int currentSeconds = 0; // 当前秒数

  int colorIndex = 0; // mainColor 在渐变数组中的位置
  Timer? _timer;
  Timer? _progressTimer; // 新增：进度条定时器

  int indexActive = 0; // 索引指示器激活位置
  final List<Map<String, dynamic>> subPages = [
    {'title': '播放器', 'key': 'player', 'index': 0},
    {'title': '歌词', 'key': 'lyrics', 'index': 1},
  ]; // 子页面数据

  // 播放器
  final AudioPlayer _audioPlayer = AudioPlayer();

  // 歌词index，
  int lyricIndex = 0;
  final ScrollController _lyricsScrollController =
      ScrollController(); // 新增：歌词滚动控制器

  // 用于处理封面水平拖动切换子页面
  double _dragStartX = 0.0;
  double _dragDx = 0.0;

  void _onPanStart(DragStartDetails details) {
    _dragStartX = details.globalPosition.dx;
    _dragDx = 0.0;
  }

  void _onPanUpdate(DragUpdateDetails details) {
    _dragDx += details.delta.dx;
  }

  void _onPanEnd(DragEndDetails details) {
    const double threshold = 50.0;
    if (_dragDx.abs() > threshold) {
      int newIndex;
      if (_dragDx < 0) {
        // 向左滑动：切到下一个子页面
        newIndex = indexActive == subPages.length - 1 ? 0 : indexActive + 1;
      } else {
        // 向右滑动：切到上一个子页面
        newIndex = indexActive == 0 ? subPages.length - 1 : indexActive - 1;
      }
      changeIndexActive(newIndex);
    }
    _dragDx = 0.0;
    _dragStartX = 0.0;
  }

  // 更新歌词索引
  void updateLyricIndex(int? index) {
    if (index != null) {
      lyricIndex = index;
      _scrollToLyric(); // 新增：滚动到当前歌词
      return;
    }

    int totalSeconds = musicActive['minutes'];
    double progress = totalSeconds == 0 ? 0 : currentSeconds / totalSeconds;
    progress = progress.clamp(0.0, 1.0);

    int newIndex = (progress * musicActive['lyrics'].length).floor();
    if (newIndex != lyricIndex) {
      lyricIndex = newIndex;
      _scrollToLyric(); // 新增：滚动到当前歌词
    }
  }

  // 更新播放器位置
  void updateAudioPosition(int newSeconds) {
    print('Updating audio position to $newSeconds seconds');
    setState(() {
      _audioPlayer.seek(Duration(seconds: newSeconds));
    });
  }

  // 新增：滚动到当前歌词
  void _scrollToLyric() {
    if (_lyricsScrollController.hasClients) {
      double itemHeight = 56.0; // 每行歌词的高度（包括 padding）
      double offset = itemHeight * lyricIndex - 100; // 减去偏移量让当前歌词显示在中间位置
      offset = offset.clamp(
        0.0,
        _lyricsScrollController.position.maxScrollExtent,
      );

      _lyricsScrollController.animateTo(
        offset,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  // 更新歌词滚动条到指定位置
  void _scrollLyricsToPosition(double position) {
    if (_lyricsScrollController.hasClients) {
      _lyricsScrollController.animateTo(
        position,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  // 渐变方向数组
  final List<List<Alignment>> gradientAlignments = [
    [Alignment.topLeft, Alignment.centerLeft],
    [Alignment.topLeft, Alignment.centerRight],
    [Alignment.topLeft, Alignment.bottomCenter],
    [Alignment.topLeft, Alignment.bottomRight],
    [Alignment.center, Alignment.bottomRight],
    [Alignment.centerLeft, Alignment.bottomRight],
    [Alignment.centerLeft, Alignment.bottomRight],
    [Alignment.topCenter, Alignment.bottomRight],
    [Alignment.topLeft, Alignment.bottomRight],
    [Alignment.topLeft, Alignment.centerRight],
  ];

  // 返回渐变颜色数组，mainColor 动态插入 colorIndex 位置
  List<Color> getGradientColorsByColor(Color color, int index) {
    List<Color> base = [
      Colors.white,
      Color(0xFFF5F5F5),
      Color(0xFFF5F5F5),
      Color(0xFFF5F5F5),
    ];
    base.insert(index.clamp(0, base.length), color);
    return base;
  }

  @override
  void initState() {
    super.initState();

    // 初始化渐变定时器
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      setState(() {
        colorIndex = (colorIndex + 1) % gradientAlignments.length; // 0~4
      });
    });

    // 初始化激活的歌曲
    musicActive = musicList.firstWhere((item) => item['key'] == keyActive);

    // 提取主色调
    getAndSetMainColor();
    totalMinutes = secondsToMinutes(musicActive['minutes']);

    // 初始化进度条定时器
    _startProgressTimer();

    // 设置播放器Url
    _setAudioSource(musicActive['audio']);
  }

  // 设置播放器音频源
  void _setAudioSource(String url) async {
    print('Setting audio source: $url');
    try {
      await _audioPlayer.setUrl(url);

      if (playing) {
        _audioPlayer.play();
      }
    } catch (e) {
      print("Error loading audio source: $e");
    }
  }

  // 新增：启动进度条定时器
  void _startProgressTimer() {
    _progressTimer?.cancel();
    if (playing) {
      _progressTimer = Timer.periodic(Duration(seconds: 1), (timer) {
        if (!playing) {
          timer.cancel();
          return;
        }
        setState(() {
          currentSeconds++;
          int totalSeconds = (musicActive['minutes']);
          if (currentSeconds >= totalSeconds) {
            currentSeconds = totalSeconds;
            playing = false;
            timer.cancel();
          }

          updateLyricIndex(null);
        });
      });
    }
  }

  // 新增：停止进度条定时器
  void _stopProgressTimer() {
    _progressTimer?.cancel();
  }

  // 秒转分钟
  String secondsToMinutes(int totalSeconds) {
    int minutes = totalSeconds ~/ 60;
    int seconds = totalSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  bool changePlaying(bool status) {
    setState(() {
      playing = status;
      if (playing) {
        _startProgressTimer();
        _audioPlayer.play();
      } else {
        _stopProgressTimer();
        _audioPlayer.pause();
      }
    });
    return playing;
  }

  void getAndSetMainColor() async {
    Color? color = await ColorExtractor.getMainColor(musicActive['cover']);

    if (color != null) {
      setState(() {
        mainColor = musicActive['mainColor'] ?? color;
      });
    }
  }

  void changeMusicActive(String type) {
    // type: pre / next
    int totalIndex = musicList.length;
    int currentIndex = musicList.indexWhere(
      (item) => item['key'] == musicActive['key'],
    );

    if (type == 'pre') {
      currentIndex = (currentIndex - 1 + totalIndex) % totalIndex;
    } else if (type == 'next') {
      currentIndex = (currentIndex + 1) % totalIndex;
    }

    musicActive = musicList[currentIndex];
    totalMinutes = secondsToMinutes(musicActive['minutes']);
    currentSeconds = 0;

    playing = true; // 切歌后自动播放

    // 设置播放器Url
    _setAudioSource(musicActive['audio']);

    // 更新歌词索引
    updateLyricIndex(null);

    // 提取主色调
    getAndSetMainColor();

    // 切歌后重启进度条定时器
    _startProgressTimer();

    // 更新歌词滚动条到顶部
    _scrollLyricsToPosition(0.0);
  }

  void changeIndexActive(int index) {
    setState(() {
      indexActive = index;
    });
  }

  void changeIndexNext() {
    setState(() {
      indexActive = indexActive == subPages.length - 1 ? 0 : indexActive + 1;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _progressTimer?.cancel(); // 新增：释放进度条定时器
    _lyricsScrollController.dispose(); // 新增：释放歌词滚动控制器
    _audioPlayer.dispose(); // 释放播放器
    super.dispose();
  }

  // 顶部条
  Widget _buildHeaderBar() {
    return Positioned(
      top: 0, // 距离顶部 20px
      left: 10,
      right: 10,
      child: Container(
        height: 80,
        padding: EdgeInsets.only(top: 40, left: 0, right: 0),
        // color: Colors.blue,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // 两端对齐
          mainAxisSize: MainAxisSize.max,

          children: [
            // 返回按钮
            IconButton(
              icon: Icon(Icons.close_sharp, color: Colors.grey, size: 24),
              onPressed: () {
                // 返回上一页
                context.pop();
              },
            ),

            Expanded(child: _buildIndexs()),

            // 右侧按钮
            IconButton(
              icon: Icon(Icons.ios_share_sharp, color: Colors.grey, size: 24),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  // 操作条
  Widget _buildActionBar() {
    return Positioned(
      bottom: 170,
      left: 20,
      right: 20,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // 两端对齐
        mainAxisSize: MainAxisSize.max,

        children: [
          IconButton(
            icon: Icon(Icons.mic_external_on_sharp, color: Colors.grey),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.radar_outlined, color: Colors.grey),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.download_sharp, color: Colors.grey),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.chat_sharp, color: Colors.grey),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_vert_sharp, color: Colors.grey),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  // 索引指示器
  Widget _buildIndexs() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(subPages.length, (index) {
        bool isActive = index == indexActive;
        return GestureDetector(
          onTap: () {
            changeIndexActive(index);
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 4),
            width: 15,
            height: 3,
            decoration: BoxDecoration(
              color: isActive ? mainColor : Colors.grey,
              // shape: BoxShape.circle,
            ),
          ),
        );
      }),
    );
  }

  // 进度条
  Widget _buildProgressBar() {
    int totalSeconds = musicActive['minutes'];
    double progress = totalSeconds == 0 ? 0 : currentSeconds / totalSeconds;
    progress = progress.clamp(0.0, 1.0);

    return Positioned(
      bottom: 110, //
      left: 20,
      right: 20,
      child: Column(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              double barWidth = constraints.maxWidth;
              double dotPosition = barWidth * progress;
              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTapDown: (details) {
                  // 正确获取 barWidth
                  double dx = details.localPosition.dx;
                  double percent = (dx / barWidth).clamp(0.0, 1.0);
                  int newSeconds = (percent * totalSeconds).round();
                  setState(() {
                    currentSeconds = newSeconds;
                    updateLyricIndex(null);
                    updateAudioPosition(newSeconds);
                  });
                  changePlaying(true); // 点击进度条后开始播放
                },
                child: Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    // 背景条
                    Container(
                      width: double.infinity,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    // 进度条
                    Container(
                      width: barWidth * progress,
                      height: 4,
                      decoration: BoxDecoration(
                        color: mainColor,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    // 圆点
                    Positioned(
                      left: dotPosition - 8, // 8为圆点半径
                      child: Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          border: Border.all(color: mainColor, width: 3),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: mainColor.withOpacity(0.3),
                              blurRadius: 4,
                              spreadRadius: 1,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          SizedBox(height: 14), // 间距

          Row(
            children: [
              Text(
                secondsToMinutes(currentSeconds),
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  decoration: TextDecoration.none,
                ),
              ),
              Spacer(),
              Text(
                totalMinutes,
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  decoration: TextDecoration.none,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 底部操作条
  Widget _buildBottomControlBar() {
    return Positioned(
      bottom: 0, // 距离底部 20px
      left: 0,
      right: 0,
      child: Center(
        // 配合 Center 实现水平居中
        child: SizedBox(
          height: 120,
          // color: Colors.blue,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            // 两端对齐
            mainAxisSize: MainAxisSize.max,

            children: [
              // 按钮，循环 ，上一个，播放/暂停， 下一个， 列表
              IconButton(
                icon: Icon(
                  Icons.low_priority_outlined,
                  color: Colors.black,
                  size: 30,
                ),
                onPressed: () {
                  // 循环
                },
              ),
              IconButton(
                icon: Icon(Icons.skip_previous, color: Colors.black, size: 30),
                onPressed: () {
                  // 上一个
                  changeMusicActive('pre');
                },
              ),
              IconButton(
                icon: Icon(
                  playing ? Icons.pause_circle_sharp : Icons.play_circle_sharp,
                  color: Colors.black,
                  size: 70,
                ),
                onPressed: () {
                  // 播放/暂停
                  changePlaying(!playing);
                },
              ),
              IconButton(
                icon: Icon(Icons.skip_next, color: Colors.black, size: 30),
                onPressed: () {
                  // 下一个
                  changeMusicActive('next');
                },
              ),
              IconButton(
                icon: Icon(Icons.queue_music, color: Colors.black, size: 30),
                onPressed: () {
                  // 列表
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 播放器子页面
  Widget _buildPlayerSubPage() {
    return Positioned.fill(
      top: 100,
      bottom: 250,
      left: 20,
      right: 20,
      child: Column(
        children: [
          // 封面
          AspectRatio(
            aspectRatio: 1.0, // 宽高比 1:1（正方形）
            child: GestureDetector(
              onTap: () {
                changeIndexNext();
              },
              // 监听水平滑动手势
              onPanStart: _onPanStart,
              onPanUpdate: _onPanUpdate,
              onPanEnd: _onPanEnd,
              child: Container(
                width: double.infinity,
                height: 300,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 16,
                      offset: Offset(0, 0),
                    ),
                  ],
                  image: DecorationImage(
                    image: NetworkImage(musicActive['cover']),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: 20), // 间距
          // 标题
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                musicActive['title'],
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none,
                ),
              ),

              IconButton(
                icon: Icon(
                  Icons.favorite,
                  color: musicActive['favorite']
                      ? Colors.redAccent
                      : Colors.grey,
                  size: 30,
                ),
                onPressed: () {
                  setState(() {
                    musicActive['favorite'] = !musicActive['favorite'];
                  });
                },
              ),
            ],
          ),
          SizedBox(height: 6), // 间距
          // 作者
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                musicActive['author'],
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 14,
                  decoration: TextDecoration.none,
                ),
              ),
              SizedBox(width: 10),
              _buildTag('关注'),
              SizedBox(width: 10),
              _buildTag('60人收听'),
              SizedBox(width: 10),
              _buildTag('SQ'),
              SizedBox(width: 10),
              _buildTag('原声'),
            ],
          ),
        ],
      ),
    );
  }

  // 歌词页子页面
  Widget _buildLyricsSubPage() {
    return Positioned.fill(
      top: 100,
      bottom: 250,
      left: 20,
      right: 20,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 歌曲名
          Text(
            musicActive['title'],
            style: TextStyle(
              color: Colors.black87,
              fontSize: 22,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.none,
            ),
          ),
          SizedBox(height: 6), // 间距
          // 作者
          Text(
            musicActive['author'],
            style: TextStyle(
              color: Colors.black87,
              fontSize: 14,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.none,
            ),
          ),
          SizedBox(height: 30), // 间距

          Expanded(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(0),
              decoration: BoxDecoration(
                // color: Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(0),
              ),
              child: SingleChildScrollView(
                controller: _lyricsScrollController, // 新增：关联滚动控制器
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: (musicActive['lyrics'] as List<dynamic>)
                      .asMap()
                      .entries
                      .map<Widget>((entry) {
                        int index = entry.key; // 索引
                        String line = entry.value[0]; // 歌词内容
                        String pinyin = entry.value.length > 1
                            ? entry.value[1]
                            : '';
                        bool isActive = index == lyricIndex;
                        return GestureDetector(
                          onTap: () {
                            // 点击歌词行，根据lyricIndex计算秒数并更新播放器位置
                            int totalSeconds = musicActive['minutes'];
                            double percent =
                                index /
                                (musicActive['lyrics'] as List<dynamic>).length;
                            int newSeconds = (percent * totalSeconds).round();
                            setState(() {
                              currentSeconds = newSeconds;
                              updateLyricIndex(index);
                              updateAudioPosition(newSeconds);
                            });
                            changePlaying(true); // 点击歌词后开始播放
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (line.isNotEmpty)
                                  Text(
                                    line,
                                    style: TextStyle(
                                      color: isActive
                                          ? mainColor
                                          : Colors.black54,
                                      fontSize: isActive ? 22.0 : 16.0,
                                      fontWeight: isActive
                                          ? FontWeight.bold
                                          : FontWeight.w400,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                if (pinyin.isNotEmpty) SizedBox(height: 4),
                                if (pinyin.isNotEmpty)
                                  Text(
                                    pinyin,
                                    style: TextStyle(
                                      color: isActive
                                          ? mainColor.withOpacity(0.7)
                                          : Colors.black38,
                                      fontSize: isActive ? 18.0 : 12.0,
                                      fontWeight: isActive
                                          ? FontWeight.w500
                                          : FontWeight.w300,
                                      decoration: TextDecoration.none,
                                    ),
                                  ),
                                SizedBox(height: 10),
                              ],
                            ),
                          ),
                        );
                      })
                      .toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 主体内容
  Widget _buildBody() {
    // 根据 indexActive 显示不同子页面
    return Stack(
      children: [
        if (indexActive == 0) _buildPlayerSubPage(),
        if (indexActive == 1) _buildLyricsSubPage(),
      ],
    );
  }

  Widget _buildTag(String text) {
    return Container(
      padding: EdgeInsets.fromLTRB(5, 3, 5, 3), // 可选，添加内边距让文字不贴边
      decoration: BoxDecoration(
        color: Colors.grey[300], // 背景色
        borderRadius: BorderRadius.circular(10), // 圆角半径
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12.0,
          fontWeight: FontWeight.w200,
          color: Colors.black54,
          decoration: TextDecoration.none,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 动画渐变背景
        AnimatedContainer(
          duration: Duration(seconds: 2),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: getGradientColorsByColor(mainColor, colorIndex),
              begin: gradientAlignments[colorIndex][0],
              end: gradientAlignments[colorIndex][1],
            ),
          ),
        ),

        // 顶部条
        _buildHeaderBar(),

        // 内容区，自动占满剩余区域
        _buildBody(),

        // 操作条
        _buildActionBar(),

        // 进度条
        _buildProgressBar(),

        // 底部操作条
        _buildBottomControlBar(),
      ],
    );
  }
}
