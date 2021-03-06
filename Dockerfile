FROM python:3.8.1-alpine3.11

WORKDIR /build

RUN apk add --no-cache --virtual .build-deps git gcc  musl-dev linux-headers make automake libtool m4 autoconf && \
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
    pip wheel . && \
    cd .. && \
    git clone https://github.com/MagicStack/uvloop && \
    cd uvloop && \
    git submodule update --init --recursive && \
    pip wheel . && \
    cd .. && \
    git clone https://github.com/aio-libs/aioredis && \
    cd aioredis && \
    pip wheel . && \
    cd .. && \
    mkdir aiohttp && \
    cd aiohttp && \
    wget https://github.com/aio-libs/aiohttp/archive/v3.6.2.tar.gz && \
    tar -xvzf v3.6.2.tar.gz && \
    cd aiohttp-3.6.2 && \
    pip wheel . && \
    cd ../.. && \
    git clone https://github.com/giampaolo/psutil && \
    cd psutil && \
    pip wheel . && \
    cd .. && \
    git clone https://github.com/scrapinghub/dateparser && \
    cd dateparser && \
    pip wheel . && \
    cd .. && \
    git clone https://github.com/Rapptz/discord.py && \
    cd discord.py && \
    git pull origin pull/1849/merge --no-edit && \
    pip wheel . && \
    cd .. && \
    git clone https://github.com/PythonistaGuild/Wavelink && \
    cd Wavelink && \
    sed -i "s:<7.0:<9.0:g" requirements.txt && \
    pip wheel . && \
    cd .. && \
    git clone https://github.com/Gelbpunkt/aiowiki && \
    cd aiowiki && \
    pip wheel . && \
    cd .. && \
    git clone https://github.com/Diniboy1123/raven-aiohttp && \
    cd raven-aiohttp && \
    pip wheel . && \
    cd .. && \
    git clone https://git.travitia.xyz/Adrian/fantasy-names && \
    cd fantasy-names && \
    pip wheel . && \
    cd .. && \
    git clone https://github.com/nir0s/distro && \
    cd distro && \
    pip wheel . && \
    cd .. && \
    git clone https://github.com/dabeaz/ply && \
    cd ply && \
    echo -e "from distutils.core import setup\nfrom Cython.Build import cythonize\nsetup(name=\"ply\", ext_modules=cythonize('ply/*.py'))" > setup.py && \
    sed -i 's/f = sys._getframe(levels)/f = sys._getframe()/' ply/lex.py && \
    sed -i 's/f = sys._getframe(levels)/f = sys._getframe()/' ply/yacc.py && \
    pip wheel . && \
    cd .. && \
    git clone https://github.com/jmoiron/humanize && \
    cd humanize && \
    pip wheel . && \
    cd .. && \
    git clone https://github.com/hellysmile/contextvars_executor && \
    cd contextvars_executor && \
    pip wheel . && \
    cd .. && \
    apk del .build-deps

# allow for build caching
RUN mkdir /wheels && \
    find . -name \*.whl -exec cp {} /wheels \;

CMD sleep 20
