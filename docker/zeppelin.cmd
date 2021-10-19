@echo off

SET DIRNAME=%~dp0
SET GITDIR="%DIRNAME%../"
REM echo %DIRNAME%

SET IM=diplodatos/bigdata:1.0

SET UID=1000

docker run -u %UID% -it --rm --hostname localhost -p 8080:8080 -p 4040:4040^
	-v "%DIRNAME%vols\conf:/opt/zeppelin/conf"^
	-v "%DIRNAME%vols\logs:/logs"^
	-v "%DIRNAME%vols\notebook:/notebook"^
	-v "%GITDIR%:/diplodatos_bigdata"^
	-e ZEPPELIN_LOG_DIR=/logs -e ZEPPELIN_NOTEBOOK_DIR=/notebook^
	--name diplodatos_bigdata %IM%
