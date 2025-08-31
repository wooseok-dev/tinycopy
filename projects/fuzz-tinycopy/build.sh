#!/bin/bash -eux
# 환경변수: $CC $CXX $CFLAGS $CXXFLAGS $SANITIZER_FLAGS $LIB_FUZZING_ENGINE $SRC $OUT

# 1) upstream 코드 가져오기 (main_repo로도 제공되지만, 명시적으로 clone하는 패턴)
cd $SRC
# 예: 여러분의 upstream 리포로 교체하세요.
#    (project.yaml의 main_repo와 일치 권장)
git clone --depth 1 https://github.com/wooseok-dev/tinycopy tinycopy

# 2) 라이브러리 빌드 (upstream Makefile 사용하지 않고 직접 빌드해도 됨)
$CC $CFLAGS $SANITIZER_FLAGS -I$SRC/tinycopy/include -c $SRC/tinycopy/src/tinycopy.c -o tinycopy.o
ar rcs libtinycopy.a tinycopy.o

# 3) 퍼저 타깃 빌드
$CC $CFLAGS $SANITIZER_FLAGS -I$SRC/tinycopy/include -c $SRC/fuzzers/fuzz_tinycopy.c -o fuzz_tinycopy.o
$CC $CFLAGS $SANITIZER_FLAGS fuzz_tinycopy.o libtinycopy.a $LIB_FUZZING_ENGINE -o $OUT/fuzz_tinycopy

# 4) 옵션/시드 복사 (있을 경우)
cp -f $SRC/fuzzers/*.options $OUT/ 2>/dev/null || true
# (원하면) 시드 코퍼스: zip -j $OUT/fuzz_tinycopy_seed_corpus.zip path/to/seeds/*
