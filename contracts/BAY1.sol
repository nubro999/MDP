// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DiaryDapp {
    enum Mood { Happy, Sad, Angry, Neutral } //enum for mood types

    struct Diary { //구조체 정의
        string title;
        string content;
        Mood mood;
        uint256 date; // timestamp (예: block.timestamp)
    }

    mapping(address => Diary[]) private diaries; // 주소별로 일기 배열을 저장하는 매핑, 여기서 diaries는 주소를 키로 하고, Diary 구조체의 배열을 값

    event DiaryWritten(address indexed writer, uint256 diaryId); //indexed? 이벤트 로그의 인덱스 필터로 저장 즉 빠른 검색가능

    // 일기 작성 함수
    function writeDiary(
        string calldata _title, //calldata 는 읽기 전용 데이터로, 함수 호출 시 전달되는 인자에 사용
        string calldata _content,
        Mood _mood,
        uint256 _date
    ) external { // external은 외부에서만 호출 가능한 함수
        require(bytes(_title).length > 0, "Title cannot be empty");
        diaries[msg.sender].push( //diaries [키] = 구조체 배열 주소값
            Diary({
                title: _title, //할당하는 문법 
                content: _content,
                mood: _mood,
                date: _date
            })
        );
        emit DiaryWritten(msg.sender, diaries[msg.sender].length - 1); //Solidity에서 이벤트(Event)를 발생시키는 키워드, 체인에 기록함
    }

    // 내 일기 전체 조회 함수
    function getMyDiaries() external view returns (Diary[] memory) { //view 는 상태를 읽기만 하는 함수
        return diaries[msg.sender];
    }

    // 내 일기의 개수 조회 함수
    function getCount() external view returns (uint256) {
        return diaries[msg.sender].length; //내 일기의 개수를 반환하는 함수
    }

    // 특정 기분의 일기 조회 함수
    function getDiaryByMood(Mood mood) external view returns (Diary[] memory) {

        uint256 count = 0;
        for (uint256 i = 0; i < diaries[msg.sender].length; i++) {
            if (diaries[msg.sender][i].mood == mood) {
                count++;
            }
        }

        Diary [] memory filteredDiaries = new Diary[](count);
        uint256 j = 0;
        for (uint256 i = 0; i < diaries[msg.sender].length; i++) {
            if (diaries[msg.sender][i].mood == mood){
                filteredDiaries[j] = diaries[msg.sender][i];
                j++;
            }
        }
        return filteredDiaries; //필터링된 일기 배열 반환
    }


    // 특정 일기 조회 함수 (옵션)
    function getDiary(uint256 _index) external view returns (Diary memory) { //_index는 일기의 인덱스
        require(_index < diaries[msg.sender].length, "Invalid index");
        return diaries[msg.sender][_index];
    }

    // 특정 기간 동안의 일기 조회 함수
    function getDiaryByPeriod(uint256 startDate, uint256 endDate) external view returns (Diary[] memory) {
        require(startDate <= endDate, "Invalid date range");

        uint256 count = 0;
        for (uint256 i = 0; i < diaries[msg.sender].length; i++) {
            if (diaries[msg.sender][i].date >= startDate && diaries[msg.sender][i].date <= endDate) {
                count++;
            }
        }

        Diary[] memory filteredDiaries = new Diary[](count);

        uint256 j = 0;
        for (uint256 i = 0; i < diaries[msg.sender].length; i++) {
            if (diaries[msg.sender][i].date >= startDate && diaries[msg.sender][i].date <= endDate) {
                filteredDiaries[j] = diaries[msg.sender][i];
                j++;
            }
        }
        return filteredDiaries;
    }

    // 키워드로 일기 제목 검색 함수
    function getDiaryByKeyword(string memory keyword) external view returns (Diary[] memory) {
        uint256 count = 0;
        for (uint256 i = 0; i < diaries[msg.sender].length; i++) {
            if (containsKeyword(diaries[msg.sender][i].title, keyword)) {
                count++;
            }
        }

        Diary[] memory filteredDiaries = new Diary[](count);

        uint256 j = 0;
        for (uint256 i = 0; i < diaries[msg.sender].length; i++) {
            if (containsKeyword(diaries[msg.sender][i].title, keyword)) {
                filteredDiaries[j] = diaries[msg.sender][i];
                j++;
            }
        }
        return filteredDiaries;
    }

    // 키워드가 포함된 일기 제목을 찾는 내부 함수
    function containsKeyword(string memory str, string memory keyword) internal pure returns (bool) {
        bytes memory strBytes = bytes (str);
        bytes memory keywordBytes = bytes(keyword);
        if (strBytes.length < keywordBytes.length) {
            return false; // 문자열이 키워드보다 짧으면 false
        }

        for (uint256 i = 0; i <= strBytes.length - keywordBytes.length; i++) {
            bool found = true;
            for (uint256 j = 0; j < keywordBytes.length; j++) {
                if (strBytes[i + j] != keywordBytes[j]) {
                    found = false;
                    break;
                }
            }
            if (found) {
                return true;
            }
        }
        return false;
    }
}
