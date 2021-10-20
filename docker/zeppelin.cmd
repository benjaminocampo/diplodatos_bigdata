@echo off

SET DIRNAME=%~dp0
SET GITDIR=%DIRNAME%../
REM echo %DIRNAME%

SET IM=diplodatos/bigdata:1.0

SET UID=1000

docker run -u %UID% -it --rm --hostname localhost -p 8080:8080 -p 4040:4040^
	-v "%DIRNAME%vols\conf:/opt/zeppelin/conf"^
	-v "%DIRNAME%vols\logs:/opt/zeppelin/logs"^
	-v "%DIRNAME%vols\notebook:/notebook"^
	-v "%GITDIR%:/diplodatos_bigdata"^
	-e ZEPPELIN_LOG_DIR=/opt/zeppelin/logs -e ZEPPELIN_NOTEBOOK_DIR=/notebook^
	-e ZEPPELIN_INTERPRETER_CONNECT_TIMEOUT=120000^
	--name diplodatos_bigdata %IM%
