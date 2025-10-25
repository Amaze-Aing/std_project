import 'package:flutter/material.dart';

// 앱을 실행하기 위한 main 함수입니다.
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Community UI',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyCommunityScreen(), // 우리가 만든 스크린을 홈으로 설정
    );
  }
}

// 요청하신 Stateless Widget 입니다.
class MyCommunityScreen extends StatelessWidget {
  const MyCommunityScreen({super.key});

  // 본문에 표시될 임시 데이터 (글 제목) - 어르신들에게 친숙한 주제로 변경
  final List<String> postTitles = const [
    '오늘 날씨가 참 좋구먼',
    '무릎 아픈데 좋은 약 아시는 분?',
    '우리 손주 사진 좀 보고 가세요',
    '내일 복지관에서 노래자랑 한다네요',
    '요즘 입맛이 없는데...',
    '경로당에서 장기 둘 사람 구함',
    '다들 건강검진은 받으셨는지?',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 1. 상단 AppBar
      appBar: AppBar(
        title: const Text(
          '이야기방', // '커뮤니티'를 '이야기방'으로 변경
          // AppBar 제목 글씨 크기 키움
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        // AppBar 하단에 버튼 영역을 2줄로 만듭니다.
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(120.0), // 높이를 120으로 늘림
          child: Container(
            color: Colors.white, // 배경색은 흰색
            child: Column(
              children: [
                // 1. 첫 번째 줄 버튼 (이야기방, 모임, 기본)
                Container(
                  height: 59.0, // 첫 번째 줄 높이
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildTopButton('이야기방',
                          isSelected: true), // '커뮤'를 '이야기방'으로 변경하고, 선택 상태(true) 전달
                      _buildTopButton('모임'), // isSelected: false (기본값)
                      _buildTopButton('기본'), // isSelected: false (기본값)
                    ],
                  ),
                ),
                const Divider(
                    height: 1.0, thickness: 1.0, color: Colors.black12), // 구분선
                // 2. 두 번째 줄 버튼 (정치, 경제, 복지)
                Container(
                  height: 60.0, // 두 번째 줄 높이
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0), // 가로 패딩 추가
                  color: Colors.grey[100], // 주제 버튼 배경색을 살짝 다르게
                  child: Row(
                    children: [
                      const Text(
                        '주제:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(width: 8.0), // '주제:'와 버튼 그룹 사이 간격
                      Expanded(
                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceEvenly, // 버튼들을 균등하게 배치
                          children: [
                            _buildTopicButton('정치'), // 새 헬퍼 메소드 사용
                            _buildTopicButton('경제'),
                            _buildTopicButton('복지'),
                          ],
                        ),
                      ),
                      // '더보기' 버튼 추가
                      _buildMoreButton(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      // 2. 본론 (글 리스트)
      body: ListView.builder(
        itemCount: postTitles.length,
        itemBuilder: (BuildContext context, int index) {
          final title = postTitles[index];
          return ListTile(
            // 목록 아이템의 상하 여백을 추가해 공간 확보
            contentPadding:
            const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            // 글 제목만 표시
            title: Text(
              title,
              style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500), // 글씨 크기를 20으로 키움
            ),
            // 우측에 Text-to-Sound 아이콘 버튼 배치
            trailing: IconButton(
              icon: const Icon(
                Icons.volume_up_outlined,
                size: 30.0, // 아이콘 크기를 30으로 키움
              ),
              tooltip: '음성으로 듣기', // 아이콘에 마우스를 올리면 표시되는 툴팁
              onPressed: () {
                // TODO: 여기에 TTS (Text-to-Speech) 로직을 구현합니다.
                // 예: ttsService.speak(title);
                print('TTS 실행: $title');
              },
            ),
            onTap: () {
              // TODO: 게시글 상세 보기 로직
              print('게시글 탭: $title');
            },
          );
        },
      ),

      // 3. 하단 버튼
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 70.0, // 하단 바 높이를 70으로 늘림
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Expanded 위젯을 사용하므로 이 속성은 제거합니다.
            children: [
              // '글쓰기' 버튼
              Expanded(
                flex: 2, // '문의' 버튼보다 2배의 비율로 공간을 차지
                child: ElevatedButton.icon(
                  icon: const Icon(
                    Icons.edit_outlined,
                    size: 28.0, // 아이콘 크기를 28로 키움
                  ),
                  label: const Text(
                    '글쓰기',
                    style:
                    TextStyle(fontSize: 18.0), // 글씨 크기를 18로 키움
                  ),
                  // 버튼의 높이를 조절
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    minimumSize: const Size(0, 50), // 버튼의 최소 높이를 50으로 설정
                  ),
                  onPressed: () {
                    // TODO: 글쓰기 화면으로 이동
                  },
                ),
              ),
              const SizedBox(width: 16.0), // 두 버튼 사이의 간격
              // '문의' 버튼
              Expanded(
                flex: 1, // 1의 비율로 공간 차지
                child: ElevatedButton.icon(
                  icon: const Icon(
                    Icons.help_outline,
                    size: 28.0, // 아이콘 크기를 28로 키움
                  ),
                  label: const Text(
                    '문의',
                    style:
                    TextStyle(fontSize: 18.0), // 글씨 크기를 18로 키움
                  ),
                  // 버튼의 높이를 조절
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    minimumSize: const Size(0, 50), // 버튼의 최소 높이를 50으로 설정
                  ),
                  onPressed: () {
                    // TODO: 문의 화면으로 이동
                  },
                ),
              ),
            ],
          ),
        ),
      ), // <--- 이 부분이 잘못된 주석 대신 괄호로 수정되었습니다.
    );
  }

  // 상단 3개 버튼을 만들기 위한 헬퍼 위젯
  Widget _buildTopButton(String text, {bool isSelected = false}) {
    // 선택되었을 때와 아닐 때의 스타일을 정의
    final selectedStyle = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.blue, // 선택되었을 때 파란색
      decoration: TextDecoration.underline, // 밑줄 추가
      decorationThickness: 2.0, // 밑줄 두께
      decorationColor: Colors.blue,
    );

    final unselectedStyle = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.black54, // 선택되지 않았을 때 회색빛
    );

    return TextButton(
      onPressed: () {
        // TODO: 각 버튼 탭 로직
      },
      style: TextButton.styleFrom(
        // 선택되었을 때 버튼에 원치 않는 패딩이 생기는 것을 방지
        minimumSize: const Size(0, 0),
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
      ),
      child: Text(
        text,
        style: isSelected ? selectedStyle : unselectedStyle,
      ),
    );
  }

  // 주제 버튼 (정치, 경제, 복지)을 만들기 위한 헬퍼 위젯
  Widget _buildTopicButton(String text) {
    return ElevatedButton(
      onPressed: () {
        // TODO: 주제별 글 보기 로직 (예: 정치 버튼 클릭 시 정치 관련 글 필터링)
        print('$text 주제 탭');
      },
      style: ElevatedButton.styleFrom(
        // 어르신들이 누르기 쉽도록 둥근 모서리와 패딩 적용
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20), // 둥근 모서리
        ),
        // '더보기' 버튼을 위한 공간을 확보하기 위해 좌우 패딩을 살짝 줄임
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 18, // 글씨 크기
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  // '더보기' 버튼을 만들기 위한 헬퍼 위젯
  Widget _buildMoreButton() {
    return TextButton(
      onPressed: () {
        // TODO: 더 많은 주제 보기 (예: 다이얼로그 또는 새 화면)
        print('더보기 탭');
      },
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
      ),
      child: const Text(
        '더보기 >',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.black54, // 눈에 띄지만 주제 버튼보다는 약하게
        ),
      ),
    );
  }
}



