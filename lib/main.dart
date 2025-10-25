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
      // 1. 상단 AppBar (변경 없음)
      appBar: AppBar(
        title: const Text(
          '모임',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: Container(
            color: Colors.white,
            child: Column(
              children: [
                Container(
                  height: 59.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildTopButton('이야기방'),
                      _buildTopButton('모임', isSelected: true),
                      _buildTopButton('기본'),
                    ],
                  ),
                ),
                const Divider(
                    height: 1.0, thickness: 1.0, color: Colors.black12),
              ],
            ),
          ),
        ),
      ),

      // 2. 본론 (변경 없음 - 비율 4:6 유지)
      body: Column(
        children: [
          // 상단 영역 (40%): 모임 카테고리
          Expanded(
            flex: 4, // 40% 차지
            child: _buildCategorySection(), // 카테고리 헬퍼 위젯 호출
          ),
          // 구분선
          const Divider(height: 8.0, thickness: 8.0, color: Colors.black12),
          // 하단 영역 (60%): 추천 모임
          Expanded(
            flex: 6, // 60% 차지
            child: _buildGatheringListSection(), // 추천 모임 헬퍼 위젯 호출
          ),
        ],
      ),

      // 3. 하단 버튼 (변경 없음)
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 70.0,
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          child: Row(
            children: [
              // '문의' 버튼
              Expanded(
                flex: 1,
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
                    minimumSize: const Size(0, 50),
                  ),
                  onPressed: () {
                    // TODO: 문의 화면으로 이동
                  },
                ),
              ),
              const SizedBox(width: 16.0),
              // '모임 만들기' 버튼
              Expanded(
                flex: 1,
                child: ElevatedButton.icon(
                  icon: const Icon(
                    Icons.add_circle_outline,
                    size: 28.0,
                  ),
                  label: const Text(
                    '모임 만들기',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(0, 50),
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    // TODO: 모임 만들기 화면으로 이동
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
    final selectedStyle = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.blue,
      decoration: TextDecoration.underline,
      decorationThickness: 2.0,
      decorationColor: Colors.blue,
    );

    final unselectedStyle = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.black54,
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

  // --- [Body를 위한 헬퍼 위젯 (수정됨)] ---

  /// 상단 (40%): 모임 카테고리 섹션을 빌드하는 위젯 (수정됨 - Request 4)
  Widget _buildCategorySection() {
    // 1. 임시 카테고리 데이터 (5개로 수정)
    final List<Map<String, dynamic>> mainCategories = [
      {'label': '운동', 'icon': Icons.fitness_center},
      {'label': '취미', 'icon': Icons.palette},
      {'label': '친목', 'icon': Icons.people},
      {'label': '봉사', 'icon': Icons.volunteer_activism},
      {'label': '학습', 'icon': Icons.school},
    ];

    // 2. 총 아이템 개수 (5개 카테고리 + 1개 더보기 = 6개)
    final int itemCount = mainCategories.length + 1; // 5 + 1 = 6

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 섹션 제목
          const Text(
            '모임 카테고리',
            style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12.0),
          // 카테고리 그리드
          Expanded(
            child: GridView.builder(
              physics:
              const NeverScrollableScrollPhysics(), // 스크롤 방지
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 2열
                childAspectRatio: 3.5 / 1, // 가로로 긴 버튼 비율
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: itemCount, // 3. itemCount 수정 (6)
              itemBuilder: (context, index) {
                // 4. '더보기' 버튼 분기 처리
                if (index == mainCategories.length) {
                  // 마지막 아이템(index 5)일 경우 '더보기' 버튼
                  return Card(
                    elevation: 1.5,
                    color: Colors.grey[200], // '더보기' 버튼은 색상을 살짝 다르게
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(8.0),
                      onTap: () {
                        // TODO: 전체 카테고리 목록 페이지로 이동
                        print('더보기 탭');
                      },
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          '더보기 +', // '더보기' 텍스트
                          style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87),
                        ),
                      ),
                    ),
                  );
                }

                // 일반 카테고리 아이템 (index 0~4)
                final category = mainCategories[index];
                return Card(
                  elevation: 1.5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(8.0),
                    onTap: () {
                      // TODO: 카테고리별 모임 목록 페이지로 이동
                      print('${category['label']} 카테고리 탭');
                    },
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        category['label'],
                        style: const TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  /// 하단 (60%): 추천 모임 리스트 섹션을 빌드하는 위젯 (변경 없음)
  Widget _buildGatheringListSection() {
    // 임시 추천 모임 데이터
    final List<String> recommendedGatherings = [
      '28일(화) 오후 2시, 공원 앞 장기 모임',
      '매주 수요일, 다같이 동네 한바퀴 산책해요',
      '[취미] 뜨개질 같이 하실 분?',
      '[운동] 아침 6시 배드민턴 클럽 회원 모집',
      '경복궁 나들이 가실 분들 모십니다 (11/5)',
      '스마트폰 사진 잘 찍는 법 배워보실 분',
    ];

    return Container(
      color: Colors.grey[100], // 상단 영역과 색상 구분
      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 섹션 제목
          const Text(
            '추천 모임',
            style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12.0),
          // 추천 모임 리스트
          Expanded(
            child: ListView.builder(
              itemCount: recommendedGatherings.length,
              itemBuilder: (context, index) {
                final item = recommendedGatherings[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 10.0),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 6.0, horizontal: 16.0),
                    leading: Icon(Icons.calendar_today_outlined,
                        size: 30.0, color: Colors.deepPurple),
                    title: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 19.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    trailing:
                    const Icon(Icons.arrow_forward_ios_rounded, size: 18.0),
                    onTap: () {
                      // TODO: 모임 상세 페이지로 이동
                      print('추천 모임 탭: $item');
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