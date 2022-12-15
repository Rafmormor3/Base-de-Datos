alter session set "_oracle_script"=true;  
create user jugadores identified by jugadores;
GRANT CONNECT, RESOURCE, DBA TO jugadores;
