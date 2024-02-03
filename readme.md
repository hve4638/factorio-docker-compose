# factorio-docker-setup

[factorio-docker](https://github.com/factoriotools/factorio-docker)의 이미지를 좀 더 간편하게 돌리기 위한 쉘스크립트 및 Makefile 집합입니다

해당 도커 이미지에 대한 세부사항 및 트러블슈팅에 대한 정보는 해당 저장소의 [readme.md](https://github.com/factoriotools/factorio-docker)를 참고하세요

## 필요 패키지

`requirement.sh` 실행시 자동으로 필요한 패키지를 설치합니다

수동 설치시 아래 패키지가 필요합니다

- `make`
- `docker`
- `docker-compose`

## 초기 세팅

`setup.sh` 실행 후 설명에 따라 다음을 입력하세요

- "factorio server directory" : 서버 디렉토리로 사용할 경로 (절대 경로로 입력)
- "savefile name" : import 시 사용할 저장 파일명

`make init`을 실행해 서버 디렉토리에 초기 파일을 생성합니다

## config 파일 수정

초기 설정이 완료되면 `Ctrl+C`로 컨테이너를 종료합니다

`make chown`을 통해 서버 디렉토리의 소유권과 접근 권한을 조정합니다

서버 디렉토리 내 `config/server-setting.json` 파일에서 서버 설정을 수정할 수 있습니다

서버를 중단 후 수정해야 변경내역이 저장됩니다

### config

*서버 관련*

- "name" : 서버 이름
- "description" : 서버 설명
- "max_players" : 최대 접속가능한 인원의 수 (0이라면 무제한)
- "game_password" : 서버 접속을 위한 비밀번호

*서버 노출 관련*

- "visibility"
    - "public" : true라면 공개 게임에 노출
    - "lan" : true라면 랜 게임에 노출
- "username" : factorio.com 로그인 아이디
- "token" : 인증 토큰

인증 아이디 및 토큰은 `%appdata%\Factorio\player-data.json` 에서 확인할 수 있습니다

username, token 은 공개 게임에 노출하지 않는다면 설정하지 않아도 됩니다

*네트워크 속도 관련*

- "max_heartbeats_per_second" : 네트워크의 틱레이트 (최소값은 6, 최대값은 240)
    - 높을수록 틱당 여러 패킷을 전송합니다
    - 낮을수록 틱레이트에 대기시간이 늘어나며 서버에 수많은 인원을 수용시 낮을수록 네트워크 트래픽에 안정적입니다
    - 원활한 네트워크 상황에선 60이 이상적

*일시정지 관련*

- "auto_pause" : true라면 서버에 플레이어가 없다면 자동으로 일시정지
- "only_admins_can_pause_the_game" : true라면 admin만 일시정지 가능

*그 외*

대부분의 설정에 주석이 쓰여 있으므로 쉡게 용도를 파악할 수 있습니다

## 명령어

```bash
make 명령어
```

`setup.sh` 스크립트를 수행 후 현 디렉토리에 `docker-compose.yml` 와 `Makefile`이 생성됩니다

이후 `make` 명령을 통해 서버 작업을 수행할 수 있습니다

| 명령어 | 설명 |
| ------| ----- |
| init | 초기 세팅 및 서버 실행 |
| hardreset | 모든 세팅 및 세이브 초기화 (실수 방지를 위해 20초의 대기 후 수행됩니다) |
| chown | 지정된 서버 디렉토리를 docker 내 사용자로 소유권 변경 |
| start | 서버 실행 |
| stop | 서버 중단 |
| log | 로그 확인 |
| upgrade | 서버 중단 및 서버 버전 갱신 (stable 기준) |
| console | 서버 콘솔 열기 |
| import-save | `./saves` 디렉토리 내 세이브파일을 서버로 가져오기 |

import-save 명령어는 `./saves/_autosave1.zip`을 서버로 가져옵니다

`./setup.sh`에서 "Savefile name"을 default가 아닌 다른 이름으로 지정했다면, `_autosave1.zip` 대신 해당 파일명으로 변경하면 됩니다

서버의 세이브파일을 내보내기 위해선 해당 파일을 직접 내보내는 것보다 클라이언트 측에서 저장하는 것을 권장합니다
