FROM gcr.io/oss-fuzz-base/base-builder

# (필요시) 빌드 도구 추가
RUN apt-get update && apt-get install -y make

# OSS-Fuzz는 /src에서 빌드 스크립트를 찾습니다.
WORKDIR /src

# 프로젝트 스크립트/퍼저 소스만 복사
COPY build.sh $SRC/
COPY fuzzers $SRC/fuzzers/

# OSS-Fuzz는 빌드 시 build.sh를 실행합니다.
