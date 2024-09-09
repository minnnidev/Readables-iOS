## 읽을거리(Readables)

<img src = "https://github.com/user-attachments/assets/568a8fd9-d269-4cf9-b0b7-34179cc6fb8f" width = 200>


읽을거리는 사용자에게 맞춤형 도서를 추천해주는 스마트한 독서 플랫폼입니다.</br>
다양한 도서의 정보를 확인하고, 관심 있는 도서에 대해 오픈톡에서 이야기를 나눠 보세요. 📚

- 개발 기간: 2024.08 ~ 진행 중
- [앱 스토어 바로가기](https://apps.apple.com/kr/app/%EC%9D%BD%EC%9D%84%EA%B1%B0%EB%A6%AC/id6664069391)
- 비고: 2024 도서관 데이터 활용 공모전 출품작

</br>


## 팀 소개

### 팀 이음

📪 Team contact: contact.ieumteam@gmail.com

| iOS Developer | iOS Developer | BackEnd Developer | BackEnd Developer |
| --- | --- | --- | --- |
| [@minnnidev](https://github.com/minnnidev) | [@rafa-e1](https://github.com/rafa-e1) | [@chanwoo7](https://github.com/chanwoo7) | [@hyeesw](https://github.com/hyeesw) |

</br>

## 기술


| 기술 | 사용 이유 |
| --- | --- |
| `UIKit` | iOS의 기본 UI 컴포넌트들을 이해하고 사용하였습니다. |
| `SnapKit`, `Then` | 코드베이스로 UI 코드를 작성하여 협업 시 원활하게 레이아웃을  설정하였습니다. |
| `Alamofire` | 네트워크 요청을 쉽게 처리할 수 있도록 Alamofire을 사용하여 네트워크 구조를 설계하였습니다. |
| `Lottie-iOS` | JSON 기반 파일을 사용하여 앱에 생동감 있는 애니메이션을 추가할 수 있었습니다. |
| `Charts` | 데이터 시각화를 위해 차트를 구현하고, 다양한 형식의 차트를 다뤘습니다. |
| `MVVM` | MVVM 아키텍처를 이해하고 필요성을 인지하도록 고민하며 개발하였습니다. |

</br>

## 서비스 주요 기능

#### 1. 회원가입 및 로그인
   - 유저는 애플 로그인, 카카오 로그인 총 2개의 소셜 로그인을 사용할 수 있으며, 입력 폼에서 정보를 입력하면 회원 가입이 완료됩니다. (닉네임만 필수 입력)
   - 한번 로그인을 하면 자동 로그인이 활성화됩니다.
     
     | 애플 로그인 | 카카오 로그인 | 정보 등록 |
     | :---: | :---: |  :---:  |
     | <img src = "https://github.com/user-attachments/assets/d2188f15-4964-42f1-a76e-56a86c4df272" width = "200"> |  <img src = "https://github.com/user-attachments/assets/d14fd416-3ceb-4e5b-96fc-ff43b6dccd03" width = "200"> | <img src = "https://github.com/user-attachments/assets/7e758873-81d2-4792-b8ed-9847f41c890a" width = "200"> |

</br>

#### 2. 맞춤형 도서 추천
   - 홈화면에서 유저는 지난달 인기 키워드를 확인할 수 있습니다.
   - 이번주 인기 도서, 유저 나이대에서 인기 있는 도서, 대출 급상승 도서를 확인할 수 있습니다.
   - 정보 등록 시 나이를 입력하지 않았다면, 전체 나이대에 인기 있는 도서를 보여줍니다.
     
     | 기본 홈화면1 | 기본 홈화면2| 나이를 입력하지 않았을 때 |
      | :---: | :---: | :---: |
      | <img src = "https://github.com/user-attachments/assets/b90eebd9-0093-49d3-aa73-9ecf63abcf4d" width = "200"> | <img src = "https://github.com/user-attachments/assets/207907b6-1f0a-4c3b-bed8-e1a353677a60" width = "200"> | <img src = "https://github.com/user-attachments/assets/450c89ad-f79f-42f7-96f5-9f1c7cf48bc7" width = "200"> |

</br>

#### 3. 키워드 검색
   - 책 이름 또는 작가 이름으로 검색을 할 수 있습니다.
   - 키워드 토글을 켜서 정보나루에서 제공하는 키워드를 사용하여 검색할 수 있습니다.

     | 일반 검색 | 키워드 검색 |
      | :---: | :---: |
      | <img src = "https://github.com/user-attachments/assets/219e97b9-195d-4704-9715-ee60bf40179d" width = "200"> | <img src = "https://github.com/user-attachments/assets/8680b6ad-64ec-4015-844b-b1a4080ed42c" width = "200">|
     
</br>

#### 4. 내 도서관 등록
   - 도서관 목록을 검색하여 나만의 도서관을 최대 3개까지 등록할 수 있습니다.
   -  지역 - 세부 지역을 나누어 검색할 수 있고, 추가, 삭제가 가능합니다.
   - 내 도서관 등록은 추후 나올 도서 상세 정보에서 도서 대출 여부를 나타낼 때 사용됩니다.

      | 내 도서관 관리 | 내 도서관 삭제 | 도서관 등록 |
      | :---: | :---: |  :---: |
      | <img src = "https://github.com/user-attachments/assets/63834604-b37b-4787-873e-0a8890bc41de" width = "200"> |  <img src = "https://github.com/user-attachments/assets/30510ba8-831c-412d-a48a-af2db2d59fec" width = "200"> |  <img src = "https://github.com/user-attachments/assets/1c701c21-da37-4d20-99a4-d65ca782d121" width = "200"> |

</br>

#### 5. 목표 
   - 도서를 검색하고 해당 도서에 대한 목표를 세울 수 있습니다. </br>
     도서의 최종 페이지 수를 입력한 뒤, 하루에 읽은 양을 기록하면 읽을거리에서 차트 정보를 제공합니다.
   - 목표를 삭제하고 완료 처리할 수 있습니다.

     | 목표 추가 | 목표 탭 | 목표 기록 |
      | :---: | :---: |  :---: |
      | <img src = "https://github.com/user-attachments/assets/ccc7b39f-f70d-40d0-89f2-598003299bde" width = "200"> |  <img src = "https://github.com/user-attachments/assets/e6cfbcb5-2af4-4d65-8deb-7b12795baa7c" width = "200"> |  <img src = "https://github.com/user-attachments/assets/a1b97886-bf09-47b3-9a56-112fb432678e" width = "200"> 
     

</br>

#### 6. 오픈톡 커뮤니티
   - 관심있는 도서에 대해 자유롭게 오픈톡에서 대화할 수 있습니다.
   - 채팅 사이드 메뉴에서 해당 도서의 목표를 진행 중인 사람, 완료한 사람을 확인하여 같이 책 읽는 분위기를 만들고자 하였습니다.
   - 해당 도서에 대한 나의 목표 진행 여부에 따라 목표 진행도와 목표 추가가 나타나도록 처리되어 있습니다.

     | 오픈톡 진입 | 채팅 | 채팅 사이드 메뉴1 | 채팅 사이드 메뉴2 |
     | :---: | :---: |  :---:  |  :---:  |
     | <img src = "https://github.com/user-attachments/assets/77dce7b3-fb67-4302-ac28-0cc34d33087a" width = "200"> |  <img src = "https://github.com/user-attachments/assets/879c1975-c69b-4383-8928-61e55b0d6832" width = "200"> |  <img src = "https://github.com/user-attachments/assets/359cc2af-7b5b-4dbd-bb1c-6f5cb5734a38" width = "200"> | <img src = "https://github.com/user-attachments/assets/8bd74d2f-c43a-4c0e-a988-d80e47ac5fcc" width = "200"> 

</br>

#### 7. 장르별 검색
   - 카테고리 탭에서는 대주제를 선택하여, 기본적으로 이번주 인기 도서와 신작 도서를 확인할 수 있습니다.
   - 각 대주제에 대한 소주제를 선택할 수 있으며, 마찬가지로 인기 도서와 신작 도서를 확인할 수 있습니다.
   - 전체보기를 통해 각 소주제에 대한 일주일 인기순, 한달 인기순, 신작순, 랜덤순 필터로 도서를 확인할 수 있습니다.
    
      | 카테고리 진입 | 인기 도서, 신작 도서 | 소주제 선택 | 필터 이용한 전체 보기 |
      | :---: | :---: |  :---:  |  :---: |
      | <img src = "https://github.com/user-attachments/assets/c49ffb68-7481-499d-91b0-aed4af967901" width = "200"> |  <img src = "https://github.com/user-attachments/assets/83d1e14a-b208-4b6e-9e9e-d63764aff833" width = "200"> |  <img src = "https://github.com/user-attachments/assets/823bcf0c-3e10-4dba-ad7c-287a57eb8722" width = "200"> | <img src = "https://github.com/user-attachments/assets/1d420f39-de01-44f2-ac7e-72d354fab937" width = "200"> |
  

</br>

#### 8. 도서 상세 정보 조회
   - 도서 상세 정보에서는 기본적인 도서 정보를 확인할수 있습니다.
   - 상세 조회 페이지에서 해당 책에 대한 오픈톡에 참여할 수 있습니다.
   - 등록한 내 도서관에서 대출이 가능한지 여부에 따라 대출 가능, 대출 불가능을 표시합니다.
         
      | 도서 상세 정보(내 도서관 등록 안 한 경우) | 대출 불가일 때 | 대출 가능할 때 |
      | :---: | :---: |  :---: |
      | <img src = "https://github.com/user-attachments/assets/a999baf9-acc1-48f1-93c1-9cbe6ce3786f" width = "200"> |  <img src = "https://github.com/user-attachments/assets/8bef9d9c-91e3-4f2a-b7e6-c5c1af5829cd" width = "200"> |  <img src = "https://github.com/user-attachments/assets/e78c900c-83b3-428c-bf30-7bf21e844fbe" width = "200"> |

</br>

#### 9. 회원 설정
   - 로그인, 로그아웃이 가능합니다. 유저에게 한번 더 의사를 물어보도록 구현하였습니다.

      | 설정 | 로그아웃 | 탈퇴하기 |
      | :---: | :---: |  :---: |
      | <img src = "https://github.com/user-attachments/assets/0031223d-6361-41a1-9ebe-9573b68c5122" width = "200"> |  <img src = "https://github.com/user-attachments/assets/9d0addf5-b3a6-4c4c-84d3-c1d86aac69ce" width = "200"> |  <img src = "https://github.com/user-attachments/assets/0318acb8-d4d9-43ef-9e44-390ffa9e3011" width = "200"> | 

</br>

## 구현 방식

#### 1. 네트워크 전체 구조
   - Moya의 사용 편리성을 큰 장점으로 느껴 Alamofire로 Moya처럼 네트워크 레이어를 구성하였습니다.
   - DTO와 Model을 엄격하게 구분하고 Service 레이어에서 매핑하였습니다.

#### 2. Authentication
   - 애플 로그인과 카카오 로그인을 연동하고, 필요한 정보를 서비스 서버로 보내 회원 인증을 진행합니다. 현재 계정 연동 상태에 따라 자동 로그인 여부를 결정하고, 도달할 화면에 대한 분기 처리를 실시하였습니다. 읽을거리에서는 JWT 토큰 기반 사용자 인증 방식을 사용합니다.
   - 읽을거리에서는 두 가지 토큰 갱신 로직이 있습니다.
        1. API 요청 성공 시 새로운 access token이 응답의 헤더로 도착합니다. 이를 캐치하고 프론트에서 access token을 갱신합니다.
        2. access token 만료 시, refresh token으로 토큰 갱신 로직을 호출합니다.
       - 위 두 가지 로직에 해당하지 않을 시, 로그인 화면으로 자동으로 이동됩니다.

#### 3. Swift Concurrency
   -  전체적인 비동기 처리를 위해 Swift Concurrency를 활용하였습니다.
   - 절대적으로 비동기 처리를 위해 작성해야 하는 코드가 줄어들었고, 이는 가독성이 크게 향상되도록 했습니다.
   - `try-catch` 를 통해 직관적인 에러 처리가 가능하도록 했습니다.


</br>

## 폴더 구조

```
📂 Resources
	ㄴ Assets
📂 Sources
	ㄴ 📂 Application
	ㄴ 📂 Model
	ㄴ 📂 Presentation
		ㄴ View
		ㄴ ViewModel
	ㄴ 📂 Network
		ㄴ API Target
		ㄴ Service 
	ㄴ 📂 DTO
	ㄴ 📂 Util
```

</br>
