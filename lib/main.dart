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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 1. 상단 AppBar (수정됨)
      appBar: AppBar(
        title: const Text(
          '이야기방',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        // AppBar 하단 버튼 영역
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60.0), // 주제 섹션이 없으므로 높이 60
          child: Container(
            color: Colors.white, // 배경색은 흰색
            child: Column(
              children: [
                // 1. 첫 번째 줄 버튼 (이야기방, 모임, 기본) - (수정된 부분)
                Container(
                  height: 59.0, // 첫 번째 줄 높이
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildTopButton('이야기방'), // isSelected: false (기본값)
                      _buildTopButton('모임'), // isSelected: false (기본값)
                      _buildTopButton('기본',
                          isSelected: true), // '기본'을 선택 상태(true)로 변경
                    ],
                  ),
                ),
                const Divider(
                    height: 1.0, thickness: 1.0, color: Colors.black12), // 구분선
              ],
            ),
          ),
        ),
      ),

      // 2. 본론 (변경 없음)
      body: Column(
        children: [
          // 상단 영역: 복지 정보
          Expanded(
            flex: 1, // 공간을 1:1 비율로 차지
            child: _buildWelfareSection(), // 복지 정보 헬퍼 위젯 호출
          ),
          // 구분선
          const Divider(height: 8.0, thickness: 8.0, color: Colors.black12),
          // 하단 영역: 추천 글/모임
          Expanded(
            flex: 1, // 공간을 1:1 비율로 차지
            child: _buildRecommendationSection(), // 추천 헬퍼 위젯 호출
          ),
        ],
      ),

      // 3. 하단 버튼 (변경 없음)
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 70.0, // 하단 바 높이를 70으로 늘림
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          child: Row(
            children: [
              // '문의' 버튼
              Expanded(
                flex: 1, // 1의 비율로 공간 차지
                child: ElevatedButton.icon(
                  icon: const Icon(
                    Icons.help_outline,
                    size: 28.0,
                  ),
                  label: const Text(
                    '문의',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  style: ElevatedButton.styleFrom(
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
      ),
    );
  }

  // 상단 3개 버튼을 만들기 위한 헬퍼 위젯 (변경 없음)
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
        minimumSize: const Size(0, 0),
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
      ),
      child: Text(
        text,
        style: isSelected ? selectedStyle : unselectedStyle,
      ),
    );
  }

  // --- [Body를 위한 헬퍼 위젯 (변경 없음)] ---

  /// 상단: 복지 정보 섹션을 빌드하는 위젯
  Widget _buildWelfareSection() {
    // 임시 복지 정보 데이터
    final List<Map<String, dynamic>> welfareInfo = [
      {'title': '기초연금 신청 안내', 'icon': Icons.savings_outlined},
      {'title': '병원비 지원 (의료급여)', 'icon': Icons.medical_services_outlined},
      {'title': '노인 일자리 정보', 'icon': Icons.work_outline},
      {'title': '치매 안심센터 찾기', 'icon': Icons.psychology_outlined},
    ];

    return Container(
      color: Colors.white, // 배경색
      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // 좌측 정렬
        children: [
          // 섹션 제목
          const Text(
            '알아두면 좋은 복지 정보',
            style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12.0),
          // 복지 정보 리스트
          Expanded(
            child: ListView.builder(
              itemCount: welfareInfo.length,
              itemBuilder: (context, index) {
                final item = welfareInfo[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 10.0),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 6.0, horizontal: 16.0),
                    leading: Icon(item['icon'],
                        size: 35.0, color: Colors.blue.shade700),
                    title: Text(
                      item['title'],
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios_rounded),
                    onTap: () {
                      // TODO: 해당 복지 정보 상세 페이지로 이동
                      print('${item['title']} 탭');
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  /// 하단: 추천 글/모임 섹션을 빌드하는 위젯
  Widget _buildRecommendationSection() {
    // 임시 추천 데이터
    final List<String> recommendedGatherings = [
      '28일(화) 오후 2시, 공원 앞 장기 모임',
      '매주 수요일, 다같이 동네 한바퀴 산책해요',
    ];
    final List<String> recommendedPosts = [
      '요즘 유행하는 트로트 노래 모음',
      '가을 단풍 구경가기 좋은 곳',
      '저녁에 먹기 좋은 건강식 아시는분?',
    ];

    final List<dynamic> items = [];
    items.add('header_gathering'); // 모임 헤더
    items.addAll(recommendedGatherings);
    items.add('header_posts'); // 이야기 헤더
    items.addAll(recommendedPosts);

    return Container(
      color: Colors.grey[100], // 상단 영역과 색상 구분
      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 전체 섹션 제목
          const Text(
            '이런 글/모임은 어떠세요?',
            style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12.0),
          // 추천 리스트
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];

                // '추천 모임' 헤더
                if (item == 'header_gathering') {
                  return const Padding(
                    padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                    child: Text(
                      '▶︎ 추천 모임',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.deepPurple,
                      ),
                    ),
                  );
                }

                // '추천 이야기' 헤더
                if (item == 'header_posts') {
                  return Padding(
                    padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
                    child: Text(
                      '▶︎ 추천 이야기',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.orange[800],
                      ),
                    ),
                  );
                }

                // 실제 추천 아이템
                return Card(
                  margin: const EdgeInsets.only(bottom: 10.0),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 4.0, horizontal: 16.0),
                    title: Text(
                      item as String,
                      style: const TextStyle(
                        fontSize: 19.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    trailing:
                    const Icon(Icons.arrow_forward_ios_rounded, size: 18.0),
                    onTap: () {
                      print('추천 아이템 탭: $item');
                    },
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}