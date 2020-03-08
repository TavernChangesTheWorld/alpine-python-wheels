FROM gelbpunkt/python:latest

WORKDIR /build

RUN pip install -U pip && \
    apk add --no-cache --virtual .build-deps git gcc  musl-dev linux-headers make automake libtool m4 autoconf jq curl && \
    git config --global user.name "Jens Reidel" && \
    git config --global user.email "jens@troet.org" && \
    git clone https://github.com/cython/cython && \
    cd cython && \
    pip wheel . && \
    pip install *.whl && \
    cd .. && \
    git clone https://github.com/MagicStack/asyncpg && \
    cd asyncpg && \
    git submodule update --init --recursive && \
    sed -i "s:0.29.14:3.0a0:g" setup.py && \
    pip wheel . && \
    pip install *.whl && \
    cd .. && \
    git clone https://github.com/MagicStack/uvloop && \
    cd uvloop && \
    git submodule update --init --recursive && \
    pip wheel . && \
    pip install *.whl && \
    cd .. && \
    git clone https://github.com/aio-libs/aioredis && \
    cd aioredis && \
    pip wheel . && \
    pip install *.whl && \
    cd .. && \
    mkdir aiohttp && \
    cd aiohttp && \
    aiohttp="$(curl -s https://pypi.org/pypi/aiohttp/json | jq -r '.info.version')" && \
    wget "https://github.com/aio-libs/aiohttp/archive/v$aiohttp.tar.gz" && \
    tar -xvzf "v$aiohttp.tar.gz" && \
    cd "aiohttp-$aiohttp" && \
    pip wheel . && \
    pip install *.whl && \
    cd ../.. && \
    git clone https://github.com/giampaolo/psutil && \
    cd psutil && \
    pip wheel . && \
    pip install *.whl && \
    cd .. && \
    git clone https://github.com/scrapinghub/dateparser && \
    cd dateparser && \
    pip wheel . && \
    pip install *.whl && \
    cd .. && \
    git clone https://github.com/Rapptz/discord.py && \
    cd discord.py && \
    git pull origin pull/1849/merge --no-edit && \
    pip wheel . && \
    pip install *.whl && \
    cd .. && \
    git clone https://github.com/PythonistaGuild/Wavelink && \
    cd Wavelink && \
    pip wheel . --no-deps && \
    pip install *.whl && \
    cd .. && \
    git clone https://github.com/Gelbpunkt/aiowiki && \
    cd aiowiki && \
    pip wheel . && \
    pip install *.whl && \
    cd .. && \
    git clone https://github.com/Diniboy1123/raven-aiohttp && \
    cd raven-aiohttp && \
    pip wheel . && \
    pip install *.whl && \
    cd .. && \
    mkdir fantasy-names && \
    cd fantasy-names && \
    wget https://github.com/Gelbpunkt/alpine-python-wheels/raw/3.9/wheels/fantasy_names-1.0.0-py3-none-any.whl && \
    pip install *.whl && \
    cd .. && \
    git clone https://github.com/nir0s/distro && \
    cd distro && \
    pip wheel . && \
    pip install *.whl && \
    cd .. && \
    git clone https://github.com/dabeaz/ply && \
    cd ply && \
    echo -e "from distutils.core import setup\nfrom Cython.Build import cythonize\nsetup(name=\"ply\", ext_modules=cythonize('ply/*.py'))" > setup.py && \
    sed -i 's/f = sys._getframe(levels)/f = sys._getframe()/' ply/lex.py && \
    sed -i 's/f = sys._getframe(levels)/f = sys._getframe()/' ply/yacc.py && \
    pip wheel . && \
    pip install *.whl && \
    cd .. && \
    git clone https://github.com/jmoiron/humanize && \
    cd humanize && \
    pip wheel . && \
    pip install *.whl && \
    cd .. && \
    git clone https://github.com/hellysmile/contextvars_executor && \
    cd contextvars_executor && \
    pip wheel . && \
    pip install *.whl && \
    cd .. && \
    apk del .build-deps

# allow for build caching
RUN mkdir /wheels && \
    find . -name \*.whl -exec cp {} /wheels \;

CMD sleep 20
