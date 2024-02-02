# 팩토리오 서버

팩토리오 서버를 docker에서 편하기 돌리기 위한 저장소를 더 편하게 돌리기 위한 저장소입니다

최소한의 서버를 돌리기 위한 기능만 제한적으로 구현되어 있습니다

더 자세한 정보와 세부 사항에 대해 확인하려면 [factorio-docker](https://github.com/factoriotools/factorio-docker) 을 참고하세요

## 필요 패키지

```bash
apt install make
curl -sSL get.docker.com | sh
```

## 세팅

`docker-compose.yml`에서 몇몇 부분을 수정해야 합니다

- volumes의 `{your_factorio_directory}` 를 서버 디렉토리로 사용할 경로로 변경
- environment의 `{your_name}`을 팩토리오 닉네임으로 변경합니다
- environment의 `{your_token}`을 팩토리오 토큰으로 변경합니다
    - 토큰은 `%Appdata%\Factorio\player-data.json` 에서 찾을 수 있습니다

`Makefile`에서 몇몇 부분을 수정해야 합니다
- FACTORIO_PATH의 `{your_factorio_directory}` 를 서버 디렉토리로 사용할 경로로 변경
    - `docker-compose.yml`의 `{your_factorio_directory}`와 동일해야 합니다

## 사용법



```bash
make <명령어>
```

| 명령어 | 설명 |
| ------| ----- |
| init | 초기 세팅을 수행 및 실행 |
| hardreset | 모든 세팅 및 세이브 초기화 (실수를 방지하기 위해 20초의 대기 후 수행됩니다) |
| chown | 지정된 설정 디렉토리를 docker 내 소유권 변경 |
| start | 서버 실행 |
| stop | 서버 중단 |
| log | 로그 확인 |
| upgrade | 서버 중단 및 서버 버전 갱신 (stable 기준) |
| console | 서버 콘솔 열기 |
| import-save | `./saves` 디렉토리 내 세이브 파일을 서버로 가져옴 |

## config 파일 수정

서버 디렉토리 내 `config/server-setting.json` 파일에서 서버 설정을 수정할 수 있습니다

서버를 중단후 수정해야 변경내역이 저장됩니다