-- 오모리
DROP SCHEMA IF EXISTS omori;

-- 오모리
CREATE SCHEMA omori;

SET FOREIGN_KEY_CHECKS=0;

-- 보기
CREATE TABLE omori.testexample (
	te_no       INTEGER NOT NULL, -- 보기번호
	tq_no       INTEGER NOT NULL, -- 문제번호
	te_small_no INTEGER NOT NULL, -- 작은번호
	te_content  TEXT    NOT NULL  -- 보기내용
);

-- 보기
ALTER TABLE omori.testexample
	ADD CONSTRAINT PK_testexample -- 보기 기본키
		PRIMARY KEY (
			te_no -- 보기번호
		);

ALTER TABLE omori.testexample
	MODIFY COLUMN te_no INTEGER NOT NULL AUTO_INCREMENT;

-- 많이친시험
CREATE TABLE omori.most_test (
	ms_no    INTEGER     NOT NULL, -- 많이친시험번호
	uid      VARCHAR(50) NOT NULL, -- 아이디
	tno      INTEGER     NOT NULL, -- 자격증번호
	ms_count INTEGER     NOT NULL  -- 시험 본 카운트
);

-- 많이친시험
ALTER TABLE omori.most_test
	ADD CONSTRAINT PK_most_test -- 많이친시험 기본키
		PRIMARY KEY (
			ms_no -- 많이친시험번호
		);

ALTER TABLE omori.most_test
	MODIFY COLUMN ms_no INTEGER NOT NULL AUTO_INCREMENT;

-- 오답노트
CREATE TABLE omori.notes (
	note_no      INTEGER     NOT NULL, -- 오답노트번호
	uid          VARCHAR(50) NOT NULL, -- 아이디
	tno          INTEGER     NOT NULL, -- 자격증번호
	tq_no        INTEGER     NOT NULL, -- 문제번호
	note_content TEXT        NOT NULL, -- 오답노트풀이내용
	note_memo    TEXT        NULL,     -- 오답노트추가메모
	note_date    TIMESTAMP   NOT NULL  -- 오답노트작성날짜
);

-- 오답노트
ALTER TABLE omori.notes
	ADD CONSTRAINT PK_notes -- 오답노트 기본키
		PRIMARY KEY (
			note_no -- 오답노트번호
		);

ALTER TABLE omori.notes
	MODIFY COLUMN note_no INTEGER NOT NULL AUTO_INCREMENT;

-- 문제
CREATE TABLE omori.testquestion (
	tq_no         INTEGER      NOT NULL, -- 문제번호
	tno           INTEGER      NOT NULL, -- 자격증번호
	tq_subject    VARCHAR(100) NULL,     -- 과목명
	tq_subject_no INTEGER      NULL,     -- 과목번호
	tq_small_no   INTEGER      NOT NULL, -- 작은번호
	tq_question   TEXT         NOT NULL, -- 문제
	tq_answer     INTEGER      NOT NULL, -- 정답
	tq_per        INTEGER      NULL      -- 오답율
);

-- 문제
ALTER TABLE omori.testquestion
	ADD CONSTRAINT PK_testquestion -- 문제 기본키
		PRIMARY KEY (
			tq_no -- 문제번호
		);

ALTER TABLE omori.testquestion
	MODIFY COLUMN tq_no INTEGER NOT NULL AUTO_INCREMENT;

-- 자격증이름
CREATE TABLE omori.testname (
	tno   INTEGER      NOT NULL, -- 자격증번호
	tname VARCHAR(100) NOT NULL, -- 자격증이름
	tdate VARCHAR(50)  NOT NULL  -- 출제년도
);

-- 자격증이름
ALTER TABLE omori.testname
	ADD CONSTRAINT PK_testname -- 자격증이름 기본키
		PRIMARY KEY (
			tno -- 자격증번호
		);

ALTER TABLE omori.testname
	MODIFY COLUMN tno INTEGER NOT NULL AUTO_INCREMENT;

-- 성적
CREATE TABLE omori.grade (
	g_no         INTEGER      NOT NULL, -- 성적번호
	uid          VARCHAR(50)  NOT NULL, -- 아이디
	tno          INTEGER      NOT NULL, -- 자격증번호
	grade        INTEGER      NOT NULL, -- 점수
	g_low        VARCHAR(100) NULL,     -- 점수가낮은과목
	g_low_grade  INTEGER      NULL,     -- 점수가낮은과목의점수
	g_high       VARCHAR(100) NULL,     -- 점수가높은과목
	g_high_grade INTEGER      NULL,     -- 점수가높은과목의점수
	g_date       VARCHAR(50)  NOT NULL  -- 시험친날짜
);

-- 성적
ALTER TABLE omori.grade
	ADD CONSTRAINT PK_grade -- 성적 기본키
		PRIMARY KEY (
			g_no -- 성적번호
		);

ALTER TABLE omori.grade
	MODIFY COLUMN g_no INTEGER NOT NULL AUTO_INCREMENT;

-- 사용자
CREATE TABLE omori.user (
	uid       VARCHAR(50) NOT NULL, -- 아이디
	upw       VARCHAR(25) NOT NULL, -- 비밀번호
	uemail    VARCHAR(50) NOT NULL, -- 이메일
	ujoindate TIMESTAMP   NOT NULL, -- 가입날짜
	isadmin   BOOLEAN     NULL     DEFAULT false -- 관리자
);

-- 사용자
ALTER TABLE omori.user
	ADD CONSTRAINT PK_user -- 사용자 기본키
		PRIMARY KEY (
			uid -- 아이디
		);

		
-- 사용자가 선택한 답
CREATE TABLE omori.selected_answer (
	sa_no     INTEGER     NOT NULL, -- 선택한답번호
	uid       VARCHAR(50) NULL,     -- 아이디
	tq_no     INTEGER     NULL,     -- 문제번호
	sa_answer INTEGER     NULL,     -- 선택한답
	sa_date   TIMESTAMP   NULL      -- 시험친날짜
);

-- 사용자가 선택한 답
ALTER TABLE omori.selected_answer
	ADD CONSTRAINT PK_selected_answer -- 사용자가 선택한 답 기본키
		PRIMARY KEY (
			sa_no -- 선택한답번호
		);

ALTER TABLE omori.selected_answer
	MODIFY COLUMN sa_no INTEGER NOT NULL AUTO_INCREMENT;


	
-- 예시이미지
CREATE TABLE omori.image (
	tq_no     INTEGER      NULL,     -- 문제번호
	imgsource VARCHAR(100) NOT NULL  -- 이미지이름
);

-- 시험본직후성적
CREATE TABLE omori.nowgrade (
	ng_no      INTEGER      NOT NULL, -- 시험본직후성적번호
	uid		   VARCHAR(50)	null,	  -- 아이디
	tno        INTEGER      NOT NULL, -- 자격증번호
	tq_subject VARCHAR(100) NOT NULL, -- 과목명
	nowgrade   INTEGER      NOT NULL, -- 점수(개수)
	ng_count   INTEGER		NOT null, -- 과목의총개수
	ng_date    TIMESTAMP    NOT NULL  -- 시험친날짜
);

-- 시험본직후성적
ALTER TABLE omori.nowgrade
	ADD CONSTRAINT PK_nowgrade -- 시험본직후성적 기본키
		PRIMARY KEY (
			ng_no -- 시험본직후성적번호
		);

ALTER TABLE omori.nowgrade
	MODIFY COLUMN ng_no INTEGER NOT NULL AUTO_INCREMENT;

-- 보기
ALTER TABLE omori.testexample
	ADD CONSTRAINT FK_testquestion_TO_testexample -- 문제 -> 보기
		FOREIGN KEY (
			tq_no -- 문제번호
		)
		REFERENCES omori.testquestion ( -- 문제
			tq_no -- 문제번호
		)on delete cascade on update cascade;

-- 많이친시험
ALTER TABLE omori.most_test
	ADD CONSTRAINT FK_user_TO_most_test -- 사용자 -> 많이친시험
		FOREIGN KEY (
			uid -- 아이디
		)
		REFERENCES omori.user ( -- 사용자
			uid -- 아이디
		)on delete cascade on update cascade;

-- 많이친시험
ALTER TABLE omori.most_test
	ADD CONSTRAINT FK_testname_TO_most_test -- 자격증이름 -> 많이친시험
		FOREIGN KEY (
			tno -- 자격증번호
		)
		REFERENCES omori.testname ( -- 자격증이름
			tno -- 자격증번호
		)on delete cascade on update cascade;

-- 오답노트
ALTER TABLE omori.notes
	ADD CONSTRAINT FK_user_TO_notes -- 사용자 -> 오답노트
		FOREIGN KEY (
			uid -- 아이디
		)
		REFERENCES omori.user ( -- 사용자
			uid -- 아이디
		)on delete cascade on update cascade;

-- 오답노트
ALTER TABLE omori.notes
	ADD CONSTRAINT FK_testname_TO_notes -- 자격증이름 -> 오답노트
		FOREIGN KEY (
			tno -- 자격증번호
		)
		REFERENCES omori.testname ( -- 자격증이름
			tno -- 자격증번호
		)on delete cascade on update cascade;

-- 오답노트
ALTER TABLE omori.notes
	ADD CONSTRAINT FK_testquestion_TO_notes -- 문제 -> 오답노트
		FOREIGN KEY (
			tq_no -- 문제번호
		)
		REFERENCES omori.testquestion ( -- 문제
			tq_no -- 문제번호
		)on delete cascade on update cascade;

-- 문제
ALTER TABLE omori.testquestion
	ADD CONSTRAINT FK_testname_TO_testquestion -- 자격증이름 -> 문제
		FOREIGN KEY (
			tno -- 자격증번호
		)
		REFERENCES omori.testname ( -- 자격증이름
			tno -- 자격증번호
		)on delete cascade on update cascade;

-- 성적
ALTER TABLE omori.grade
	ADD CONSTRAINT FK_user_TO_grade -- 사용자 -> 성적
		FOREIGN KEY (
			uid -- 아이디
		)
		REFERENCES omori.user ( -- 사용자
			uid -- 아이디
		)on delete cascade on update cascade;

-- 성적
ALTER TABLE omori.grade
	ADD CONSTRAINT FK_testname_TO_grade -- 자격증이름 -> 성적
		FOREIGN KEY (
			tno -- 자격증번호
		)
		REFERENCES omori.testname ( -- 자격증이름
			tno -- 자격증번호
		)on delete cascade on update cascade;

-- 사용자가 선택한 답
ALTER TABLE omori.selected_answer
	ADD CONSTRAINT FK_testquestion_TO_selected_answer -- 문제 -> 사용자가 선택한 답
		FOREIGN KEY (
			tq_no -- 문제번호
		)
		REFERENCES omori.testquestion ( -- 문제
			tq_no -- 문제번호
		)on delete cascade on update cascade;

-- 사용자가 선택한 답
ALTER TABLE omori.selected_answer
	ADD CONSTRAINT FK_user_TO_selected_answer -- 사용자 -> 사용자가 선택한 답
		FOREIGN KEY (
			uid -- 아이디
		)
		REFERENCES omori.user ( -- 사용자
			uid -- 아이디
		)on delete cascade on update cascade;

use omori;

create index idx_tqno on selected_answer(tq_no);
create index idx_uid on selected_answer(uid);
-- ----------------------------------------------------------------------------------------

insert into user(uid, upw, uemail, ujoindate, isadmin) values('test1', 'test1', 'test1@naver.com',now(), false);
insert into user(uid, upw, uemail, ujoindate, isadmin) values('test2', 'test2', 'test2@naver.com',now(), false);
insert into user values('admin', 'admin', 'admin@naver.com',now(), true);
select uid, upw, uemail, ujoindate, isadmin from user where uid = 'test2';
select * from user;

LOAD DATA LOCAL INFILE "D:\\workspace\\workspace_spring\\Omori_Ver2\\DataFiles\\testname.txt" INTO TABLE testname 
FIELDS TERMINATED BY '\t';
insert into testname(tname, tdate) values('정보처리기사 2016년 1회', '2016-03-06');
update testname set tno = 1 where tno = 7;
select * from testname order by tname;
delete from testname;

LOAD DATA LOCAL INFILE "D:\\workspace\\workspace_spring\\Omori_Ver2\\DataFiles\\testquestion.txt" INTO TABLE testquestion 
FIELDS TERMINATED BY '\t' LINES TERMINATED BY '\n';
LOAD DATA LOCAL INFILE "D:\\workspace\\workspace_spring\\Omori_Ver2\\DataFiles\\testquestion2.txt" INTO TABLE testquestion 
FIELDS TERMINATED BY '\t' LINES TERMINATED BY '\n';
insert into testquestion(tno, tq_subject, tq_subject_no, tq_small_no, tq_question, tq_answer, tq_per) 
values(1, '데이터베이스', 1, 1, '문제1', '1', '10');
insert into testquestion(tno, tq_subject, tq_subject_no, tq_small_no, tq_question, tq_answer, tq_per) 
values(1, '데이터베이스', 1, 2, '문제2', '2', '20');
-- 과목명만 모아 보기
select distinct tq_subject from testquestion where tno = 1;
-- 한 과목당 문제 개수
select count(*) from testquestion where tno = 1 and tq_subject = '데이터베이스'; 
-- 모의 시험
select * from testquestion where tno = 1 order by tq_small_no;
-- 과목별 시험
select * from testquestion where tno = 1 and tq_subject_no = 1 order by tq_small_no;
-- 한문제씩 풀기
select * from testquestion where tno = 1 and tq_small_no = 1;

delete from testquestion;
alter table testquestion auto_increment = 1;

insert into image values(1, 'image1');
-- 문제 1번 이미지
select * from image where tq_no = 1 order by tq_no;
select * from image;
delete from image;

LOAD DATA LOCAL INFILE "D:\\workspace\\workspace_spring\\Omori_Ver2\\DataFiles\\testexample.txt" INTO TABLE testexample 
FIELDS TERMINATED BY '\t' LINES TERMINATED BY '\n';
LOAD DATA LOCAL INFILE "D:\\workspace\\workspace_spring\\Omori_Ver2\\DataFiles\\testexample2.txt" INTO TABLE testexample 
FIELDS TERMINATED BY '\t' LINES TERMINATED BY '\n';
insert into testexample(tq_no, te_small_no, te_content) values(1, 1, '문제1번의 예시1');
insert into testexample(tq_no, te_small_no, te_content) values(1, 2, '문제1번의 예시2');
insert into testexample(tq_no, te_small_no, te_content) values(1, 3, '문제1번의 예시3');
insert into testexample(tq_no, te_small_no, te_content) values(1, 4, '문제1번의 예시4');
select * from testexample;
-- 문제 1번의 객관식 보기
select * from testexample where tq_no = 101 order by te_small_no;
-- 문제 1번의 보기와 답
select e.* from testexample e inner join testquestion q on e.te_small_no = q.tq_answer
where e.tq_no = 1 and q.tq_no = 1;
delete from testexample;
alter table testexample auto_increment = 1;

insert into selected_answer(uid, tq_no, sa_answer, sa_date) values('test1', 1, 1, now());
-- 문제 1번에 대해 제일 최근 test1유저가 선택한 답
select * from selected_answer where tq_no = 1 and uid='test1' order by sa_date desc limit 1;
-- 문제 1번에 대해 2017-05-31일 test2유저가 선택한 답과 정답이 일치하는지 확인
select s.* from selected_answer s inner join testquestion q on s.sa_answer = q.tq_answer
where s.tq_no = 1 and q.tq_no = 1 and s.uid = 'test2' and s.sa_date = '2017-05-31';
delete from selected_answer;
alter table selected_answer auto_increment = 1;

insert into nowgrade(uid, tno, tq_subject, nowgrade, ng_date) values('test1', 1, '데이터베이스', 18, now());
insert into nowgrade(uid, tno, tq_subject, nowgrade, ng_date) values('test1', 1, '전자계산기구조', 18, now());
insert into nowgrade(uid, tno, tq_subject, nowgrade, ng_date) values('test1', 1, '운영체제', 18, now());
insert into nowgrade(uid, tno, tq_subject, nowgrade, ng_date) values('test1', 1, '소프트웨어공학', 18, now());
insert into nowgrade(uid, tno, tq_subject, nowgrade, ng_date) values('test1', 1, '데이터통신', 18, now());

-- 제일 최근에 본 시험의 점수
select * from nowgrade where tno = 1 and tq_subject = '데이터베이스' and uid='test1' order by ng_date desc limit 1;
select * from nowgrade;

delete from nowgrade;
alter table nowgrade auto_increment = 1;

insert into grade(uid, tno, grade, g_low, g_low_grade, g_high, g_high_grade, g_date) values('test1', 1, 75, '데이터베이스', 17, '전자계산기구조', 18, '2017-05-31');
insert into grade(uid, tno, grade, g_low, g_high, g_date) values('test1', 1, 67, '데이터베이스', '전자계산기구조', '2017-05-30');
insert into grade(uid, tno, grade, g_low, g_high, g_date) values('test1', 1, 80, '데이터베이스', '전자계산기구조', '2017-05-31');
insert into grade(uid, tno, grade, g_low, g_high, g_date) values('test1', 1, 80, '데이터베이스', '전자계산기구조', '2017-05-31');
-- 'test1'이 최근 본 시험 성적 순으로 정렬
select * from grade where uid = 'test2' order by g_date desc, g_no desc;
select * from grade;

insert into notes(uid, tno, tq_no, sa_no, note_content, note_memo, note_date) values('test1', 1, 1, 1, '오답풀이', null, now());
select * from notes;

insert into most_test(uid, tno, ms_count) values('test1', 1, 5);
select * from most_test;