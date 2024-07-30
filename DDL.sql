S-- 1. 유저 권한 및 DB 생성

show databases;

use mysql;

select * from user;

create database toolmanager;

show grants for 'test'@'%';

grant all privileges on toolmanager.* to 'test'@'%';

use toolmanager;


-- 2. 테이블 생성

drop table if exists customer cascade;
drop table if exists tool cascade;
drop table if exists jig_type cascade;

create table if not exists customer
(
	  customer_id	int auto_increment not null primary key comment '고객ID'
	, customer_name	varchar(50) not null comment '고객명'
	, customer_nickname	varchar(50) not null comment '고객닉네임'
	, responsibility	varchar(50) not null comment '담당자'
	, phone1	varchar(13) not null comment '연락처1'
	, phone2	varchar(13) comment '연락처2'
	, email	varchar(255) comment '이메일'
	, website	varchar(255) comment '웹사이트'
	, payment_day	varchar(255) comment '결제일'
);

desc customer;

CREATE table if not exists tool
(
	  tool_id	int auto_increment not null primary key comment '툴ID'
	, j_serial	int comment '지그시리얼넘버'
	, s_serial int comment '제판시리얼넘버'
	, customer_id	int not null comment '고객ID'
	, tool_number	varchar(255) not null comment '툴넘버'
	, model_number	varchar(255) not null comment '모델넘버'
	, j_type	int comment '지그종류'
	, j_thickness int comment '지그두께'
	, j_cutting	int comment '지그가공종류'
	, j_hole_count	int comment '지그홀개수'
	, s_type	int comment '제판종류'
	, s_mesh	int comment '제판메쉬'
	, s_emulsion	int comment '제판유제종류'
	, arrival_date	date comment '입고일'
	, memo	varchar(255) comment '메모'
	, jig_or_ss	char(1) not null comment '지그제판구분'
);

-- 테이블 순서 구분 없이 생성하기 위해 외래 키 제약 조건 별도 추가
alter table tool add constraint fk_j_serial foreign key (j_serial) references jig_serial(jig_serial_id);
alter table tool add constraint fk_s_serial foreign key (s_serial) references ss_serial(ss_serial_id);
alter table tool add constraint fk_customer_id foreign key (customer_id) references customer(customer_id);
alter table tool add constraint fk_jig_type foreign key (j_type) references jig_type(jig_type_id);
alter table tool add constraint fk_jig_thickness foreign key (j_thickness) references jig_thickness(jig_thickness_id);
alter table tool add constraint fk_jig_cutting foreign key (j_cutting) references jig_cutting(jig_cutting_id);
alter table tool add constraint fk_ss_type foreign key (s_type) references ss_type(ss_type_id);
alter table tool add constraint fk_ss_mesh foreign key (s_mesh) references ss_mesh(ss_mesh_id);
alter table tool add constraint fk_ss_emulsion foreign key (s_emulsion) references ss_emulsion_type(ss_emulsion_id);

alter table tool add constraint check_jig_or_ss check (
    (jig_or_ss = 'j' and j_serial is not null and j_type is not null and j_thickness is not null and j_cutting is not null and j_hole_count is not null
    and s_serial is null and s_type is null and s_mesh is null and s_emulsion is null)
    or 
    (jig_or_ss = 's' and j_serial is null and j_type is null and j_thickness is null and j_cutting is null and j_hole_count is null
    and s_serial is not null and s_type is not null and s_mesh is not null and s_emulsion is not null)
);




desc tool;

CREATE table if not exists jig_type
(
	  jig_type_id	int auto_increment not null primary key comment '지그종류'
	, jig_type_name	varchar(50) not null comment '지그종류이름'
);

desc jig_type;

CREATE table if not exists jig_thickness
(
	  jig_thickness_id	int auto_increment not null primary key comment '지그두께ID'
	, jig_thickness_name	varchar(50) not null comment '지그두께이름'
);

desc jig_thickness;

CREATE table if not exists jig_cutting
(
	  jig_cutting_id int auto_increment not null primary key comment '지그가공ID'
	, jig_cutting_name	varchar(50) not null comment '지그가공이름'
);

desc jig_cutting;

CREATE table if not exists ss_type
(
	  ss_type_id int auto_increment not null primary key comment '제판종류'
	, ss_type_name	varchar(50) not null comment '제판종류이름'
);

desc ss_type;

CREATE table if not exists ss_mesh
(
	  ss_mesh_id	int auto_increment not null primary key comment '제판메쉬ID'
	, ss_mesh_count	int not null comment '제판메쉬개수'
);

desc ss_mesh;

CREATE table if not exists ss_emulsion_type
(
	  ss_emulsion_id int auto_increment not null primary key comment '제판유제ID'
	, ss_emulsion_name	varchar(50) not null comment '제판유제이름'
);

desc ss_emulsion_type;

CREATE table if not exists jig_serial
(
	  jig_serial_id int not null primary key comment '지그시리얼ID'
);

desc jig_serial;

CREATE table if not exists ss_serial
(
	  ss_serial_id int not null primary key comment '제판시리얼ID'
);

desc ss_serial;

CREATE TABLE if NOT EXISTS user
(
	  user_id	INT NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT '사용자ID'
	, email	VARCHAR(255) NOT NULL COMMENT '이메일'
	, PASSWORD	VARCHAR(255) NOT NULL COMMENT '비밀번호'
	, NAME	VARCHAR(255) NOT NULL COMMENT '실명'
	, nickname	VARCHAR(50) NOT NULL COMMENT '닉네임'
	, birth	DATE NOT NULL COMMENT '생년월일'
	, auth	CHAR(1) NOT NULL COMMENT '역할'	-- enum? boolean? char?
);

