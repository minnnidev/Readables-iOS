//
//  RegionType.swift
//  BookTalk
//
//  Created by 김민 on 8/23/24.
//

import Foundation

enum RegionType: CaseIterable {
    case seoul
    case busan
    case daegu
    case incheon
    case gwangju
    case daejeon
    case ulsan
    case sejong
    case gyeonggi
    case gangwon
    case chungbuk
    case chungnam
    case jeonbuk
    case jeonnam
    case gyeongbuk
    case gyeongnam
    case jeju


    var name: String {
        switch self {
        case .seoul:
            return "서울"
        case .busan:
            return "부산"
        case .daegu:
            return "대구"
        case .incheon:
            return "인천"
        case .gwangju:
            return "광주"
        case .daejeon:
            return "대전"
        case .ulsan:
            return "울산"
        case .sejong:
            return "세종"
        case .gyeonggi:
            return "경기"
        case .gangwon:
            return "강원"
        case .chungbuk:
            return "충북"
        case .chungnam:
            return "충남"
        case .jeonbuk:
            return "전북"
        case .jeonnam:
            return "전남"
        case .gyeongbuk:
            return "경북"
        case .gyeongnam:
            return "경남"
        case .jeju:
            return "제주"
        }
    }

    var code: String {
        switch self {
        case .seoul:
            return "11"
        case .busan:
            return "21"
        case .daegu:
            return "22"
        case .incheon:
            return "23"
        case .gwangju:
            return "24"
        case .daejeon:
            return "25"
        case .ulsan:
            return "26"
        case .sejong:
            return "29"
        case .gyeonggi:
            return "31"
        case .gangwon:
            return "32"
        case .chungbuk:
            return "33"
        case .chungnam:
            return "34"
        case .jeonbuk:
            return "35"
        case .jeonnam:
            return "36"
        case .gyeongbuk:
            return "37"
        case .gyeongnam:
            return "38"
        case .jeju:
            return "39"
        }
    }

    var detailRegions: [DetailRegion] {
        switch self {
        case .seoul:
            return [
                .init(code: "11010", name: "종로구"),
                .init(code: "11020", name: "중구"),
                .init(code: "11030", name: "용산구"),
                .init(code: "11040", name: "성동구"),
                .init(code: "11050", name: "광진구"),
                .init(code: "11060", name: "동대문구"),
                .init(code: "11070", name: "중랑구"),
                .init(code: "11080", name: "성북구"),
                .init(code: "11090", name: "강북구"),
                .init(code: "11100", name: "도봉구"),
                .init(code: "11110", name: "노원구"),
                .init(code: "11120", name: "은평구"),
                .init(code: "11130", name: "서대문구"),
                .init(code: "11140", name: "마포구"),
                .init(code: "11150", name: "양천구"),
                .init(code: "11160", name: "강서구"),
                .init(code: "11170", name: "구로구"),
                .init(code: "11180", name: "금천구"),
                .init(code: "11190", name: "영등포구"),
                .init(code: "11200", name: "동작구"),
                .init(code: "11210", name: "관악구"),
                .init(code: "11220", name: "서초구"),
                .init(code: "11230", name: "강남구"),
                .init(code: "11240", name: "송파구"),
                .init(code: "11250", name: "강동구")
            ]
        case .busan:
            return [
                .init(code: "21010", name: "중구"),
                .init(code: "21020", name: "서구"),
                .init(code: "21030", name: "동구"),
                .init(code: "21040", name: "영도구"),
                .init(code: "21050", name: "부산진구"),
                .init(code: "21060", name: "동래구"),
                .init(code: "21070", name: "남구"),
                .init(code: "21080", name: "북구"),
                .init(code: "21090", name: "해운대구"),
                .init(code: "21100", name: "사하구"),
                .init(code: "21110", name: "금정구"),
                .init(code: "21120", name: "강서구"),
                .init(code: "21130", name: "연제구"),
                .init(code: "21140", name: "수영구"),
                .init(code: "21150", name: "사상구"),
                .init(code: "21310", name: "기장군")
            ]
        case .daegu:
            return [
                .init(code: "22010", name: "중구"),
                .init(code: "22020", name: "동구"),
                .init(code: "22030", name: "서구"),
                .init(code: "22040", name: "남구"),
                .init(code: "22050", name: "북구"),
                .init(code: "22060", name: "수성구"),
                .init(code: "22070", name: "달서구"),
                .init(code: "22310", name: "달성군")
            ]
        case .incheon:
            return [
                .init(code: "23010", name: "중구"),
                .init(code: "23020", name: "동구"),
                .init(code: "23030", name: "남구"),
                .init(code: "23040", name: "연수구"),
                .init(code: "23050", name: "남동구"),
                .init(code: "23060", name: "부평구"),
                .init(code: "23070", name: "계양구"),
                .init(code: "23080", name: "서구"),
                .init(code: "23310", name: "강화군"),
                .init(code: "23320", name: "옹진군")
            ]
        case .gwangju:
            return [
                .init(code: "24010", name: "동구"),
                .init(code: "24020", name: "서구"),
                .init(code: "24030", name: "남구"),
                .init(code: "24040", name: "북구"),
                .init(code: "24050", name: "광산구")
            ]
        case .daejeon:
            return [
                .init(code: "25010", name: "동구"),
                .init(code: "25020", name: "중구"),
                .init(code: "25030", name: "서구"),
                .init(code: "25040", name: "유성구"),
                .init(code: "25050", name: "대덕구")
            ]
        case .ulsan:
            return [
                .init(code: "26010", name: "중구"),
                .init(code: "26020", name: "남구"),
                .init(code: "26030", name: "동구"),
                .init(code: "26040", name: "북구"),
                .init(code: "26310", name: "울주군")
            ]
        case .sejong:
            return [
                .init(code: "29010", name: "세종시")
            ]
        case .gyeonggi:
            return [
                .init(code: "31010", name: "수원시"),
                .init(code: "31011", name: "수원시 장안구"),
                .init(code: "31012", name: "수원시 권선구"),
                .init(code: "31013", name: "수원시 팔달구"),
                .init(code: "31014", name: "수원시 영통구"),
                .init(code: "31020", name: "성남시"),
                .init(code: "31021", name: "성남시 수정구"),
                .init(code: "31022", name: "성남시 중원구"),
                .init(code: "31023", name: "성남시 분당구"),
                .init(code: "31030", name: "의정부시"),
                .init(code: "31040", name: "안양시"),
                .init(code: "31041", name: "안양시 만안구"),
                .init(code: "31042", name: "안양시 동안구"),
                .init(code: "31050", name: "부천시"),
                .init(code: "31060", name: "광명시"),
                .init(code: "31070", name: "평택시"),
                .init(code: "31080", name: "동두천시"),
                .init(code: "31090", name: "안산시"),
                .init(code: "31091", name: "안산시 상록구"),
                .init(code: "31092", name: "안산시 단원구"),
                .init(code: "31100", name: "고양시"),
                .init(code: "31101", name: "고양시 덕양구"),
                .init(code: "31103", name: "고양시 일산동구"),
                .init(code: "31104", name: "고양시 일산서구"),
                .init(code: "31110", name: "과천시"),
                .init(code: "31120", name: "구리시"),
                .init(code: "31130", name: "남양주시"),
                .init(code: "31140", name: "오산시"),
                .init(code: "31150", name: "시흥시"),
                .init(code: "31160", name: "군포시"),
                .init(code: "31170", name: "의왕시"),
                .init(code: "31180", name: "하남시"),
                .init(code: "31190", name: "용인시"),
                .init(code: "31191", name: "용인시 처인구"),
                .init(code: "31192", name: "용인시 기흥구"),
                .init(code: "31193", name: "용인시 수지구"),
                .init(code: "31200", name: "파주시"),
                .init(code: "31210", name: "이천시"),
                .init(code: "31220", name: "안성시"),
                .init(code: "31230", name: "김포시"),
                .init(code: "31240", name: "화성시"),
                .init(code: "31250", name: "광주시"),
                .init(code: "31260", name: "양주시"),
                .init(code: "31270", name: "포천시"),
                .init(code: "31280", name: "여주시"),
                .init(code: "31350", name: "연천군"),
                .init(code: "31370", name: "가평군"),
                .init(code: "31380", name: "양평군")
            ]
        case .gangwon:
            return [
                .init(code: "32010", name: "춘천시"),
                .init(code: "32020", name: "원주시"),
                .init(code: "32030", name: "강릉시"),
                .init(code: "32040", name: "동해시"),
                .init(code: "32050", name: "태백시"),
                .init(code: "32060", name: "속초시"),
                .init(code: "32070", name: "삼척시"),
                .init(code: "32310", name: "홍천군"),
                .init(code: "32320", name: "횡성군"),
                .init(code: "32330", name: "영월군"),
                .init(code: "32340", name: "평창군"),
                .init(code: "32350", name: "정선군"),
                .init(code: "32360", name: "철원군"),
                .init(code: "32370", name: "화천군"),
                .init(code: "32380", name: "양구군"),
                .init(code: "32390", name: "인제군"),
                .init(code: "32400", name: "고성군"),
                .init(code: "32410", name: "양양군")
            ]
        case .chungbuk:
            return [
                .init(code: "33010", name: "청주시"),
                .init(code: "33020", name: "충주시"),
                .init(code: "33030", name: "제천시"),
                .init(code: "33040", name: "청주시 상당구"),
                .init(code: "33041", name: "청주시 서원구"),
                .init(code: "33042", name: "청주시 흥덕구"),
                .init(code: "33043", name: "청주시 청원구"),
                .init(code: "33050", name: "보은군"),
                .init(code: "33060", name: "옥천군"),
                .init(code: "33070", name: "영동군"),
                .init(code: "33080", name: "진천군"),
                .init(code: "33090", name: "괴산군"),
                .init(code: "33100", name: "음성군"),
                .init(code: "33110", name: "단양군"),
                .init(code: "33120", name: "증평군")
            ]
        case .chungnam:
            return [
                .init(code: "34010", name: "천안시"),
                .init(code: "34011", name: "천안시 동남구"),
                .init(code: "34012", name: "천안시 서북구"),
                .init(code: "34020", name: "공주시"),
                .init(code: "34030", name: "보령시"),
                .init(code: "34040", name: "아산시"),
                .init(code: "34050", name: "서산시"),
                .init(code: "34060", name: "논산시"),
                .init(code: "34070", name: "계룡시"),
                .init(code: "34080", name: "당진시"),
                .init(code: "34310", name: "금산군"),
                .init(code: "34330", name: "부여군"),
                .init(code: "34340", name: "서천군"),
                .init(code: "34350", name: "청양군"),
                .init(code: "34360", name: "홍성군"),
                .init(code: "34370", name: "예산군"),
                .init(code: "34380", name: "태안군")
            ]
        case .jeonbuk:
            return [
                .init(code: "35010", name: "전주시"),
                .init(code: "35011", name: "전주시 완산구"),
                .init(code: "35012", name: "전주시 덕진구"),
                .init(code: "35020", name: "군산시"),
                .init(code: "35030", name: "익산시"),
                .init(code: "35040", name: "정읍시"),
                .init(code: "35050", name: "남원시"),
                .init(code: "35060", name: "김제시"),
                .init(code: "35310", name: "완주군"),
                .init(code: "35320", name: "진안군"),
                .init(code: "35330", name: "무주군"),
                .init(code: "35340", name: "장수군"),
                .init(code: "35350", name: "임실군"),
                .init(code: "35360", name: "순창군"),
                .init(code: "35370", name: "고창군"),
                .init(code: "35380", name: "부안군")
            ]

        case .jeonnam:
            return [
                .init(code: "36010", name: "목포시"),
                .init(code: "36020", name: "여수시"),
                .init(code: "36030", name: "순천시"),
                .init(code: "36040", name: "나주시"),
                .init(code: "36050", name: "광양시"),
                .init(code: "36310", name: "담양군"),
                .init(code: "36320", name: "곡성군"),
                .init(code: "36330", name: "구례군"),
                .init(code: "36340", name: "고흥군"),
                .init(code: "36350", name: "보성군"),
                .init(code: "36360", name: "화순군"),
                .init(code: "36370", name: "장흥군"),
                .init(code: "36380", name: "강진군"),
                .init(code: "36390", name: "해남군"),
                .init(code: "36400", name: "영암군"),
                .init(code: "36410", name: "무안군"),
                .init(code: "36420", name: "함평군"),
                .init(code: "36430", name: "영광군"),
                .init(code: "36440", name: "장성군"),
                .init(code: "36450", name: "완도군"),
                .init(code: "36460", name: "진도군"),
                .init(code: "36470", name: "신안군")
            ]
        case .gyeongbuk:
            return [
                .init(code: "37010", name: "포항시"),
                .init(code: "37011", name: "포항시 남구"),
                .init(code: "37012", name: "포항시 북구"),
                .init(code: "37020", name: "경주시"),
                .init(code: "37030", name: "김천시"),
                .init(code: "37040", name: "안동시"),
                .init(code: "37050", name: "구미시"),
                .init(code: "37060", name: "영주시"),
                .init(code: "37070", name: "영천시"),
                .init(code: "37080", name: "상주시"),
                .init(code: "37090", name: "문경시"),
                .init(code: "37100", name: "경산시"),
                .init(code: "37110", name: "군위군"),
                .init(code: "37120", name: "의성군"),
                .init(code: "37130", name: "청송군"),
                .init(code: "37140", name: "영양군"),
                .init(code: "37150", name: "영덕군"),
                .init(code: "37160", name: "청도군"),
                .init(code: "37170", name: "고령군"),
                .init(code: "37180", name: "성주군"),
                .init(code: "37190", name: "칠곡군"),
                .init(code: "37200", name: "예천군"),
                .init(code: "37210", name: "봉화군"),
                .init(code: "37220", name: "울진군"),
                .init(code: "37230", name: "울릉군")
            ]
        case .gyeongnam:
            return [
                .init(code: "38010", name: "창원시"),
                .init(code: "38011", name: "창원시 의창구"),
                .init(code: "38012", name: "창원시 성산구"),
                .init(code: "38013", name: "창원시 마산합포구"),
                .init(code: "38014", name: "창원시 마산회원구"),
                .init(code: "38015", name: "창원시 진해구"),
                .init(code: "38020", name: "진주시"),
                .init(code: "38030", name: "통영시"),
                .init(code: "38050", name: "사천시"),
                .init(code: "38060", name: "김해시"),
                .init(code: "38070", name: "밀양시"),
                .init(code: "38080", name: "거제시"),
                .init(code: "38090", name: "양산시"),
                .init(code: "38100", name: "의령군"),
                .init(code: "38110", name: "함안군"),
                .init(code: "38120", name: "창녕군"),
                .init(code: "38130", name: "고성군"),
                .init(code: "38140", name: "남해군"),
                .init(code: "38150", name: "하동군"),
                .init(code: "38160", name: "산청군"),
                .init(code: "38170", name: "함양군"),
                .init(code: "38180", name: "거창군"),
                .init(code: "38190", name: "합천군")
            ]
        case .jeju:
            return [
                .init(code: "39010", name: "제주시"),
                .init(code: "39020", name: "서귀포시")
            ]
        }
    }
}

struct DetailRegion {
    let code: String
    let name: String
}
