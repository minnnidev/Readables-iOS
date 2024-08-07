//
//  FirstCategoryType.swift
//  BookTalk
//
//  Created by 김민 on 7/25/24.
//

import Foundation

enum CategoryType: Int, CaseIterable {
    case generalWorks
    case philosophy
    case religion
    case socialScience
    case naturalScience
    case descriptiveScience
    case art
    case linguistic
    case literature
    case history

    var title: String {
        switch self {
        case .generalWorks:
            return "총류"
        case .philosophy:
            return "철학"
        case .religion:
            return "종교"
        case .socialScience:
            return "사회과학"
        case .naturalScience:
            return "자연과학"
        case .descriptiveScience:
            return "기술과학"
        case .art:
            return "예술"
        case .linguistic:
            return "언어"
        case .literature:
            return "문학"
        case .history:
            return "역사"
        }
    }

    var subCategories: [String] {
        switch self {
        case .generalWorks:
            return [
                "전체", "도서학, 서지학", "문헌정보학", "백과사전", "일반 논문집", "일반 연속간행물",
                "학·협회,기관", "신문, 언론, 저널리즘", "일반 전집, 총서", "향토자료"
            ]

        case .philosophy:
            return [
                "전체", "형이상학", "인식론, 인과론, 인간학", "철학의 체계", "경학", "동양 철학, 사상",
                "서양철학", "논리학", "심리학", "윤리학, 도덕철학"
            ]

        case .religion:
            return [
                "전체", "비교종교학", "불교", "기독교", "도교", "천도교", "신도", "바라문교, 인도교",
                "회교(이슬람교)", "기타 제종교"
            ]

        case .socialScience:
            return [
                "전체", "통계학", "경제학", "사회학, 사회문제", "정치학", "행정학", "법학", "교육학",
                "풍속, 민속학", "국방, 군사학"
            ]

        case .naturalScience:
            return [
                "전체", "수학", "물리학", "화학", "천문학", "지학", "광물학", "생물과학", "식물학", "동물학"
            ]

        case .descriptiveScience:
            return [
                "전체", "의학", "농업, 농학", "공학, 공업일반", "건축공학", "기계공학", "전기공학, 전자공학",
                "화학공학", "제조업", "가정학 및 가정생활"
            ]

        case .art:
            return [
                "전체", "건축술", "조각", "공예, 장식미술", "서예", "회화, 도화", "사진술", "음악",
                "연극", "오락, 운동"
            ]

        case .linguistic:
            return [
                "전체", "한국어", "중국어", "일본어", "영어", "독일어", "프랑스어", "스페인어",
                "이탈리아어", "기타 제어"
            ]

        case .literature:
            return [
                "전체", "한국문학", "중국문학", "일본문학", "영미문학", "독일문학", "프랑스문학", "스페인문학",
                "이탈리아문학", "기타 제문학"
            ]

        case .history:
            return [
                "전체", "아시아(아세아)", "유럽(구라파)", "아프리카", "북아메리카(북미)", "남아메리카(남미)",
                "오세아니아(대양주)", "양극지방", "지리", "전기"
            ]
        }
    }
}
