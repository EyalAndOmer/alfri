-- Seed data derived from scratch2.txt (GRANT removed, double semicolons fixed)
-- NOTE: This file executes raw INSERTs; ensure schema is empty or IDs do not clash.

insert into public.answer_type (answer_type_id, name) values (1, 'TEXT');
insert into public.answer_type (answer_type_id, name) values (2, 'NUMERIC');
insert into public.answer_type (answer_type_id, name) values (3, 'RADIO');
insert into public.answer_type (answer_type_id, name) values (4, 'CHECKBOX');
insert into public.answer_type (answer_type_id, name) values (5, 'DROPDOWN');
insert into public.answer_type (answer_type_id, name) values (6, 'GRADE');


INSERT INTO public.role (role_id, name) VALUES (2, 'teacher');
INSERT INTO public.role (role_id, name) VALUES (1, 'student');
INSERT INTO public.role (role_id, name) VALUES (3, 'visitor');

INSERT INTO public.study_program (study_program_id, name) VALUES (3, 'informatika');

INSERT INTO public."user" (user_id, role_id, email, first_name, last_name, password) VALUES (1, 1, 'nagy1@stud.uniza.sk', 'Adam', 'Nagy', '$2a$10$FWZ7zGzeQGdlMX3Bd.nTTOYyY0n8GtsGdgq53a414w65OPHgOv8Me');
INSERT INTO public."user" (user_id, role_id, email, first_name, last_name, password) VALUES (2, 1, 'majba@stud.uniza.sk', 'Maroš', 'Majba', '$2a$10$.s7derW1HlXmpRLyTEJjGOZEV6nZEuYYZqAWYXrIauIHLPm9u5mI6');
INSERT INTO public."user" (user_id, role_id, email, first_name, last_name, password) VALUES (3, 1, 'szathmary@stud.uniza.sk', 'Peter', 'Szathmáry', '$2a$10$rcn.t1DBfl67OcbY/5bqmeRGLuSVkueYmp19I/CgfMz0sQuS1UbM2');

-- Subjects
INSERT INTO public.subject (subject_id, name, code, abbreviation) VALUES (1, 'algebra', '6BA0001', 'Alg');
INSERT INTO public.subject (subject_id, name, code, abbreviation) VALUES (2, 'matematika pre informatikov', '6BA0009', 'MpInf');
INSERT INTO public.subject (subject_id, name, code, abbreviation) VALUES (3, 'úvod do štúdia', '6BH0003', 'ÚŠ');
INSERT INTO public.subject (subject_id, name, code, abbreviation) VALUES (4, 'informatika 1', '6BI0011', 'INF1');
INSERT INTO public.subject (subject_id, name, code, abbreviation) VALUES (5, 'základy ekonómie', '6BM0027', 'ZE');
INSERT INTO public.subject (subject_id, name, code, abbreviation) VALUES (6, 'praktické cvičenia z matematiky 1', '6BA0012', 'PCzM1');
INSERT INTO public.subject (subject_id, name, code, abbreviation) VALUES (7, 'praktikum z programovania 1', '6BI0032', 'PrzPr1');
INSERT INTO public.subject (subject_id, name, code, abbreviation) VALUES (8, 'slovenský jazyk 1', '6BJ0011', 'JS1');
INSERT INTO public.subject (subject_id, name, code, abbreviation) VALUES (9, 'telesná výchova 1', '6BT0001', 'TV1');
INSERT INTO public.subject (subject_id, name, code, abbreviation) VALUES (10, 'algoritmická teória grafov', '6BA0002', 'ATG');
INSERT INTO public.subject (subject_id, name, code, abbreviation) VALUES (11, 'diskrétna pravdepodobnosť', '6BA0005', 'DPrav');
INSERT INTO public.subject (subject_id, name, code, abbreviation) VALUES (12, 'informatika 2', '6BI0012', 'INF2');
INSERT INTO public.subject (subject_id, name, code, abbreviation) VALUES (13, 'princípy IKS', '6BI0034', 'PIKS');
INSERT INTO public.subject (subject_id, name, code, abbreviation) VALUES (14, 'ekonomické a právne aspekty podnikania', '6BL0001', 'EaPAP');
INSERT INTO public.subject (subject_id, name, code, abbreviation) VALUES (15, 'praktické cvičenia z matematiky 2', '6BA0013', 'PCzM2');
INSERT INTO public.subject (subject_id, name, code, abbreviation) VALUES (16, 'linux - základy', '6BI0018', 'L-z');
INSERT INTO public.subject (subject_id, name, code, abbreviation) VALUES (17, 'praktikum z programovania 2', '6BI0033', 'PrzPr2');
INSERT INTO public.subject (subject_id, name, code, abbreviation) VALUES (18, 'úvod do operačných systémov', '6BI0046', 'UdOS');
INSERT INTO public.subject (subject_id, name, code, abbreviation) VALUES (19, 'slovenský jazyk 2', '6BJ0012', 'SJ2');
INSERT INTO public.subject (subject_id, name, code, abbreviation) VALUES (20, 'telesná výchova 2', '6BT0002', 'TV2');
INSERT INTO public.subject (subject_id, name, code, abbreviation) VALUES (21, 'telovýchovné sústredenie 1', '6BT0007', 'TVS1');
INSERT INTO public.subject (subject_id, name, code, abbreviation) VALUES (22, 'matematická analýza 1', '6BA0006', 'MatA1');
INSERT INTO public.subject (subject_id, name, code, abbreviation) VALUES (23, 'číslicové počítače', '6BI0003', 'ČísPoč');
INSERT INTO public.subject (subject_id, name, code, abbreviation) VALUES (24, 'informatika 3', '6BI0013', 'INF3');
INSERT INTO public.subject (subject_id, name, code, abbreviation) VALUES (25, 'logické systémy', '6BI0019', 'LogS');
INSERT INTO public.subject (subject_id, name, code, abbreviation) VALUES (26, 'strojovo orientované jazyky', '6BI0039', 'SOJaz');
INSERT INTO public.subject (subject_id, name, code, abbreviation) VALUES (27, '3D tlač', '6BI0001', '3DT');
INSERT INTO public.subject (subject_id, name, code, abbreviation) VALUES (28, 'počítačové siete 1', '6BI0026', 'PS1');
INSERT INTO public.subject (subject_id, name, code, abbreviation) VALUES (29, 'analýza procesov', '6UI0005', 'AP');
INSERT INTO public.subject (subject_id, name, code, abbreviation) VALUES (30, 'praktické cvičenia z matematiky 3', '6BA0014', 'PCzM3');
INSERT INTO public.subject (subject_id, name, code, abbreviation) VALUES (31, 'digitálne meny a blockchain', '6BI0007', 'DMB');
INSERT INTO public.subject (subject_id, name, code, abbreviation) VALUES (32, 'otvorené geografické dáta 1', '6BI0023', 'OGD1');
INSERT INTO public.subject (subject_id, name, code, abbreviation) VALUES (33, 'UNIX - vývojové prostredie', '6BI0045', 'UNIXVP');
INSERT INTO public.subject (subject_id, name, code, abbreviation) VALUES (34, 'jazyk anglický 1', '6BJ0005', 'JA1_inf');
INSERT INTO public.subject (subject_id, name, code, abbreviation) VALUES (35, 'ekonómia podniku', '6BM0003', 'EP');
INSERT INTO public.subject (subject_id, name, code, abbreviation) VALUES (36, 'povolanie podnikateľ 1', '6BM0019', 'PP1');
INSERT INTO public.subject (subject_id, name, code, abbreviation) VALUES (37, 'telesná výchova 3', '6BT0003', 'TV3');
INSERT INTO public.subject (subject_id, name, code, abbreviation) VALUES (38, 'telovýchovné sústredenie 2', '6BT0008', 'TVS2');
INSERT INTO public.subject (subject_id, name, code, abbreviation) VALUES (39, 'diskrétna optimalizácia', '6BA0004', 'DO');
INSERT INTO public.subject (subject_id, name, code, abbreviation) VALUES (40, 'databázové systémy', '6BI0005', 'DS');
INSERT INTO public.subject (subject_id, name, code, abbreviation) VALUES (41, 'pravdepodobnosť a štatistika', '6UA0002', 'PaŠ');
INSERT INTO public.subject (subject_id, name, code, abbreviation) VALUES (42, 'algoritmy a údajové štruktúry 1', '6UI0004', 'AaUD1');
INSERT INTO public.subject (subject_id, name, code, abbreviation) VALUES (43, 'matematická analýza 2', '6BA0007', 'MatA2');
INSERT INTO public.subject (subject_id, name, code, abbreviation) VALUES (44, 'jazyk C# a .NET', '6BI0016', 'JCN');
INSERT INTO public.subject (subject_id, name, code, abbreviation) VALUES (45, 'počítačové siete 2', '6BI0027', 'PS2');
INSERT INTO public.subject (subject_id, name, code, abbreviation) VALUES (46, 'softvérové modelovanie', '6BI0038', 'SF');
INSERT INTO public.subject (subject_id, name, code, abbreviation) VALUES (47, 'vývoj aplikácií pre mobilné zariadenia', '6BI0048', 'VAMZ');
INSERT INTO public.subject (subject_id, name, code, abbreviation) VALUES (48, 'numerické metódy', '6BA0011', 'NM');
INSERT INTO public.subject (subject_id, name, code, abbreviation) VALUES (49, 'sociológia', '6BH0002', 'Soc');
INSERT INTO public.subject (subject_id, name, code, abbreviation) VALUES (50, 'metaprogramovanie', '6BI0021', 'MT');
INSERT INTO public.subject (subject_id, name, code, abbreviation) VALUES (51, 'otvorené geografické dáta 2', '6BI0024', 'OGD2');
INSERT INTO public.subject (subject_id, name, code, abbreviation) VALUES (52, 'techniky programovania 1', '6BI0041', 'TechP1');
INSERT INTO public.subject (subject_id, name, code, abbreviation) VALUES (53, 'jazyk anglický 2', '6BJ0006', 'JA2_inf');
INSERT INTO public.subject (subject_id, name, code, abbreviation) VALUES (54, 'povolanie podnikateľ 2', '6BM0020', 'PP2');
INSERT INTO public.subject (subject_id, name, code, abbreviation) VALUES (55, 'telesná výchova 4', '6BT0004', 'TV4');
INSERT INTO public.subject (subject_id, name, code, abbreviation) VALUES (56, 'tabuľkové procesory', '6UI0002', 'TP');
INSERT INTO public.subject (subject_id, name, code, abbreviation) VALUES (57, 'elektronické spracovanie a prezentácia dokumentov', '6UI0006', 'ESPD');
INSERT INTO public.subject (subject_id, name, code, abbreviation) VALUES (58, 'makroekonómia', '6UM0002', 'ME');
INSERT INTO public.subject (subject_id, name, code, abbreviation) VALUES (59, 'princípy operačných systémov', '6BI0035', 'POS');
INSERT INTO public.subject (subject_id, name, code, abbreviation) VALUES (60, 'anglický jazyk bc. 1', '6BJ0001', 'AJB1');
INSERT INTO public.subject (subject_id, name, code, abbreviation) VALUES (61, 'modelovanie a simulácia', '6UA0003', 'MS');
INSERT INTO public.subject (subject_id, name, code, abbreviation) VALUES (62, 'softvérové inžinierstvo', '6UI0010', 'SI');
INSERT INTO public.subject (subject_id, name, code, abbreviation) VALUES (63, 'vývoj aplikácií pre internet a intranet', '6UI0012', 'VAII');
INSERT INTO public.subject (subject_id, name, code, abbreviation) VALUES (64, 'modelovanie a optimalizácia', '6BA0010', 'ModaOp');
INSERT INTO public.subject (subject_id, name, code, abbreviation) VALUES (65, 'počítačové siete 3', '6BI0028', 'PS3');
INSERT INTO public.subject (subject_id, name, code, abbreviation) VALUES (66, 'dáta, informácie, znalosti', '6UA0001', 'DIZ');
INSERT INTO public.subject (subject_id, name, code, abbreviation) VALUES (67, 'matematická analýza 3', '6BA0008', 'MatA3');
INSERT INTO public.subject (subject_id, name, code, abbreviation) VALUES (68, 'python v sieťových aplikáciách', '6BI0037', 'PSA');
INSERT INTO public.subject (subject_id, name, code, abbreviation) VALUES (69, 'technické prostriedky PC', '6BI0040', 'TP-PC');
INSERT INTO public.subject (subject_id, name, code, abbreviation) VALUES (70, 'techniky programovania 2', '6BI0042', 'TechP2');
INSERT INTO public.subject (subject_id, name, code, abbreviation) VALUES (71, 'zabezpečenie sietí zariadeniami Fortinet', '6BI0052', 'ZSZF');
INSERT INTO public.subject (subject_id, name, code, abbreviation) VALUES (72, 'základy programovania vo Windows', '6BI0054', 'ZPrvW');
INSERT INTO public.subject (subject_id, name, code, abbreviation) VALUES (73, 'základy testovania softvéru', '6BI0055', 'ZTS');
INSERT INTO public.subject (subject_id, name, code, abbreviation) VALUES (74, 'ekonómia v praxi', '6BM0029', 'EvP');
INSERT INTO public.subject (subject_id, name, code, abbreviation) VALUES (75, 'telesná výchova 5', '6BT0005', 'TV5');
INSERT INTO public.subject (subject_id, name, code, abbreviation) VALUES (76, 'internet vecí', '6UI0007', 'IV');
INSERT INTO public.subject (subject_id, name, code, abbreviation) VALUES (77, 'dane a rozpočet', '6UM0004', 'DaR');
INSERT INTO public.subject (subject_id, name, code, abbreviation) VALUES (78, 'podnikové financie', '6UM0007', 'PF');
INSERT INTO public.subject (subject_id, name, code, abbreviation) VALUES (79, 'anglický jazyk bc. 2', '6BJ0002', 'AJB2');
INSERT INTO public.subject (subject_id, name, code, abbreviation) VALUES (80, 'prax', '6BX0001', 'Prax');
INSERT INTO public.subject (subject_id, name, code, abbreviation) VALUES (81, 'bakalárska práca', '6BZ0001', 'BP');
INSERT INTO public.subject (subject_id, name, code, abbreviation) VALUES (82, 'analýza viacrozmerných dát', '6BA0003', 'AVD');
INSERT INTO public.subject (subject_id, name, code, abbreviation) VALUES (83, 'implementácie UNIXu-LINUX', '6BI0009', 'IU-Lin');
INSERT INTO public.subject (subject_id, name, code, abbreviation) VALUES (84, 'vývoj aplikácií v Unity3D', '6BI0049', 'VAU3D');
INSERT INTO public.subject (subject_id, name, code, abbreviation) VALUES (85, 'vývoj pokročilých aplikácií', '6BI0050', 'VPA');
INSERT INTO public.subject (subject_id, name, code, abbreviation) VALUES (86, 'telesná výchova 6', '6BT0006', 'TV6');
INSERT INTO public.subject (subject_id, name, code, abbreviation) VALUES (87, 'manažérska komunikácia', '6UM0005', 'MaKo');

-- Students
INSERT INTO public.student (student_id, user_id, study_program_id, year) VALUES (3, 2, 3, 3);
INSERT INTO public.student (student_id, user_id, study_program_id, year) VALUES (2, 1, 3, 2);
INSERT INTO public.student (student_id, user_id, study_program_id, year) VALUES (4, 3, 3, 4);

-- Student subjects
INSERT INTO public.student_subject (student_id, subject_id, mark, year)
VALUES (4, 147, 'B', 3);
INSERT INTO public.student_subject (student_id, subject_id, mark, year)
VALUES (3, 110, 'D', 2);
INSERT INTO public.student_subject (student_id, subject_id, mark, year)
VALUES (2, 108, 'A', 1);
INSERT INTO public.student_subject (student_id, subject_id, mark, year)
VALUES (4, 93, 'C', 1);
INSERT INTO public.student_subject (student_id, subject_id, mark, year)
VALUES (4, 91, 'A', 1);
INSERT INTO public.student_subject (student_id, subject_id, mark, year)
VALUES (4, 89, 'B', 1);
INSERT INTO public.student_subject (student_id, subject_id, mark, year)
VALUES (3, 90, 'A', 1);
INSERT INTO public.student_subject (student_id, subject_id, mark, year)
VALUES (2, 93, 'D', 1);
INSERT INTO public.student_subject (student_id, subject_id, mark, year)
VALUES (2, 90, 'E', 1);
INSERT INTO public.student_subject (student_id, subject_id, mark, year)
VALUES (4, 92, 'B', 1);
INSERT INTO public.student_subject (student_id, subject_id, mark, year)
VALUES (2, 92, 'A', 1);
INSERT INTO public.student_subject (student_id, subject_id, mark, year)
VALUES (2, 91, 'C', 1);
INSERT INTO public.student_subject (student_id, subject_id, mark, year)
VALUES (4, 90, 'A', 1);
INSERT INTO public.student_subject (student_id, subject_id, mark, year)
VALUES (3, 91, 'D', 1);
INSERT INTO public.student_subject (student_id, subject_id, mark, year)
VALUES (2, 89, 'E', 1);
INSERT INTO public.student_subject (student_id, subject_id, mark, year)
VALUES (3, 89, 'C', 1);
INSERT INTO public.student_subject (student_id, subject_id, mark, year)
VALUES (3, 93, 'B', 1);
INSERT INTO public.student_subject (student_id, subject_id, mark, year)
VALUES (3, 92, 'D', 1);

-- Focus data
INSERT INTO public.focus (math_focus, logic_focus, programming_focus, design_focus, economics_focus, management_focus,
                          hardware_focus, network_focus, data_focus, testing_focus, language_focus, physical_focus,
                          subject_id)
VALUES (10, 8, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 89);
INSERT INTO public.focus (math_focus, logic_focus, programming_focus, design_focus, economics_focus, management_focus,
                          hardware_focus, network_focus, data_focus, testing_focus, language_focus, physical_focus,
                          subject_id)
VALUES (10, 8, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 90);
INSERT INTO public.focus (math_focus, logic_focus, programming_focus, design_focus, economics_focus, management_focus,
                          hardware_focus, network_focus, data_focus, testing_focus, language_focus, physical_focus,
                          subject_id)
VALUES (2, 4, 0, 6, 0, 4, 0, 0, 3, 0, 2, 0, 91);
INSERT INTO public.focus (math_focus, logic_focus, programming_focus, design_focus, economics_focus, management_focus,
                          hardware_focus, network_focus, data_focus, testing_focus, language_focus, physical_focus,
                          subject_id)
VALUES (0, 9, 10, 4, 0, 0, 0, 0, 5, 6, 2, 0, 92);
INSERT INTO public.focus (math_focus, logic_focus, programming_focus, design_focus, economics_focus, management_focus,
                          hardware_focus, network_focus, data_focus, testing_focus, language_focus, physical_focus,
                          subject_id)
VALUES (6, 6, 0, 0, 10, 3, 0, 0, 2, 0, 0, 0, 93);
INSERT INTO public.focus (math_focus, logic_focus, programming_focus, design_focus, economics_focus, management_focus,
                          hardware_focus, network_focus, data_focus, testing_focus, language_focus, physical_focus,
                          subject_id)
VALUES (10, 8, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 94);
INSERT INTO public.focus (math_focus, logic_focus, programming_focus, design_focus, economics_focus, management_focus,
                          hardware_focus, network_focus, data_focus, testing_focus, language_focus, physical_focus,
                          subject_id)
VALUES (0, 6, 10, 2, 0, 0, 0, 0, 2, 5, 0, 0, 95);
INSERT INTO public.focus (math_focus, logic_focus, programming_focus, design_focus, economics_focus, management_focus,
                          hardware_focus, network_focus, data_focus, testing_focus, language_focus, physical_focus,
                          subject_id)
VALUES (0, 4, 0, 0, 0, 5, 0, 0, 0, 0, 10, 0, 96);
INSERT INTO public.focus (math_focus, logic_focus, programming_focus, design_focus, economics_focus, management_focus,
                          hardware_focus, network_focus, data_focus, testing_focus, language_focus, physical_focus,
                          subject_id)
VALUES (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 97);
INSERT INTO public.focus (math_focus, logic_focus, programming_focus, design_focus, economics_focus, management_focus,
                          hardware_focus, network_focus, data_focus, testing_focus, language_focus, physical_focus,
                          subject_id)
VALUES (7, 10, 6, 2, 0, 0, 0, 3, 5, 0, 0, 0, 98);
INSERT INTO public.focus (math_focus, logic_focus, programming_focus, design_focus, economics_focus, management_focus,
                          hardware_focus, network_focus, data_focus, testing_focus, language_focus, physical_focus,
                          subject_id)
VALUES (10, 7, 0, 0, 0, 0, 0, 0, 8, 0, 0, 0, 99);
INSERT INTO public.focus (math_focus, logic_focus, programming_focus, design_focus, economics_focus, management_focus,
                          hardware_focus, network_focus, data_focus, testing_focus, language_focus, physical_focus,
                          subject_id)
VALUES (0, 9, 10, 4, 0, 0, 0, 0, 5, 6, 2, 0, 100);
INSERT INTO public.focus (math_focus, logic_focus, programming_focus, design_focus, economics_focus, management_focus,
                          hardware_focus, network_focus, data_focus, testing_focus, language_focus, physical_focus,
                          subject_id)
VALUES (4, 6, 3, 2, 0, 0, 6, 10, 0, 0, 0, 0, 101);
INSERT INTO public.focus (math_focus, logic_focus, programming_focus, design_focus, economics_focus, management_focus,
                          hardware_focus, network_focus, data_focus, testing_focus, language_focus, physical_focus,
                          subject_id)
VALUES (2, 4, 0, 8, 10, 10, 0, 0, 0, 0, 0, 0, 102);
INSERT INTO public.focus (math_focus, logic_focus, programming_focus, design_focus, economics_focus, management_focus,
                          hardware_focus, network_focus, data_focus, testing_focus, language_focus, physical_focus,
                          subject_id)
VALUES (10, 8, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 103);
INSERT INTO public.focus (math_focus, logic_focus, programming_focus, design_focus, economics_focus, management_focus,
                          hardware_focus, network_focus, data_focus, testing_focus, language_focus, physical_focus,
                          subject_id)
VALUES (0, 8, 8, 0, 0, 0, 4, 7, 0, 0, 0, 0, 104);
INSERT INTO public.focus (math_focus, logic_focus, programming_focus, design_focus, economics_focus, management_focus,
                          hardware_focus, network_focus, data_focus, testing_focus, language_focus, physical_focus,
                          subject_id)
VALUES (0, 9, 10, 4, 0, 0, 0, 0, 5, 6, 2, 0, 105);
INSERT INTO public.focus (math_focus, logic_focus, programming_focus, design_focus, economics_focus, management_focus,
                          hardware_focus, network_focus, data_focus, testing_focus, language_focus, physical_focus,
                          subject_id)
VALUES (0, 9, 6, 0, 0, 0, 4, 6, 0, 0, 0, 0, 106);
INSERT INTO public.focus (math_focus, logic_focus, programming_focus, design_focus, economics_focus, management_focus,
                          hardware_focus, network_focus, data_focus, testing_focus, language_focus, physical_focus,
                          subject_id)
VALUES (0, 4, 0, 0, 0, 5, 0, 0, 0, 0, 10, 0, 107);
INSERT INTO public.focus (math_focus, logic_focus, programming_focus, design_focus, economics_focus, management_focus,
                          hardware_focus, network_focus, data_focus, testing_focus, language_focus, physical_focus,
                          subject_id)
VALUES (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 108);
INSERT INTO public.focus (math_focus, logic_focus, programming_focus, design_focus, economics_focus, management_focus,
                          hardware_focus, network_focus, data_focus, testing_focus, language_focus, physical_focus,
                          subject_id)
VALUES (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 109);
INSERT INTO public.focus (math_focus, logic_focus, programming_focus, design_focus, economics_focus, management_focus,
                          hardware_focus, network_focus, data_focus, testing_focus, language_focus, physical_focus,
                          subject_id)
VALUES (10, 8, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 110);
INSERT INTO public.focus (math_focus, logic_focus, programming_focus, design_focus, economics_focus, management_focus,
                          hardware_focus, network_focus, data_focus, testing_focus, language_focus, physical_focus,
                          subject_id)
VALUES (4, 10, 8, 4, 0, 0, 10, 0, 0, 0, 0, 0, 111);
INSERT INTO public.focus (math_focus, logic_focus, programming_focus, design_focus, economics_focus, management_focus,
                          hardware_focus, network_focus, data_focus, testing_focus, language_focus, physical_focus,
                          subject_id)
VALUES (0, 9, 10, 4, 0, 0, 0, 0, 5, 6, 2, 0, 112);
INSERT INTO public.focus (math_focus, logic_focus, programming_focus, design_focus, economics_focus, management_focus,
                          hardware_focus, network_focus, data_focus, testing_focus, language_focus, physical_focus,
                          subject_id)
VALUES (4, 10, 8, 4, 0, 0, 10, 0, 0, 0, 0, 0, 113);
INSERT INTO public.focus (math_focus, logic_focus, programming_focus, design_focus, economics_focus, management_focus,
                          hardware_focus, network_focus, data_focus, testing_focus, language_focus, physical_focus,
                          subject_id)
VALUES (4, 10, 9, 4, 0, 0, 7, 0, 0, 0, 0, 0, 114);
INSERT INTO public.focus (math_focus, logic_focus, programming_focus, design_focus, economics_focus, management_focus,
                          hardware_focus, network_focus, data_focus, testing_focus, language_focus, physical_focus,
                          subject_id)
VALUES (0, 4, 0, 10, 0, 0, 10, 0, 0, 0, 0, 0, 115);
INSERT INTO public.focus (math_focus, logic_focus, programming_focus, design_focus, economics_focus, management_focus,
                          hardware_focus, network_focus, data_focus, testing_focus, language_focus, physical_focus,
                          subject_id)
VALUES (0, 7, 6, 2, 0, 0, 3, 10, 0, 0, 0, 0, 116);
INSERT INTO public.focus (math_focus, logic_focus, programming_focus, design_focus, economics_focus, management_focus,
                          hardware_focus, network_focus, data_focus, testing_focus, language_focus, physical_focus,
                          subject_id)
VALUES (9, 10, 0, 0, 4, 0, 0, 0, 10, 0, 0, 0, 117);
INSERT INTO public.focus (math_focus, logic_focus, programming_focus, design_focus, economics_focus, management_focus,
                          hardware_focus, network_focus, data_focus, testing_focus, language_focus, physical_focus,
                          subject_id)
VALUES (10, 8, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 118);
INSERT INTO public.focus (math_focus, logic_focus, programming_focus, design_focus, economics_focus, management_focus,
                          hardware_focus, network_focus, data_focus, testing_focus, language_focus, physical_focus,
                          subject_id)
VALUES (2, 8, 0, 0, 10, 2, 0, 0, 6, 0, 0, 0, 119);
INSERT INTO public.focus (math_focus, logic_focus, programming_focus, design_focus, economics_focus, management_focus,
                          hardware_focus, network_focus, data_focus, testing_focus, language_focus, physical_focus,
                          subject_id)
VALUES (0, 4, 2, 8, 0, 0, 0, 0, 6, 0, 0, 0, 120);
INSERT INTO public.focus (math_focus, logic_focus, programming_focus, design_focus, economics_focus, management_focus,
                          hardware_focus, network_focus, data_focus, testing_focus, language_focus, physical_focus,
                          subject_id)
VALUES (0, 8, 8, 0, 0, 0, 4, 7, 0, 0, 0, 0, 121);
INSERT INTO public.focus (math_focus, logic_focus, programming_focus, design_focus, economics_focus, management_focus,
                          hardware_focus, network_focus, data_focus, testing_focus, language_focus, physical_focus,
                          subject_id)
VALUES (0, 7, 2, 0, 0, 8, 0, 0, 0, 0, 10, 0, 122);
INSERT INTO public.focus (math_focus, logic_focus, programming_focus, design_focus, economics_focus, management_focus,
                          hardware_focus, network_focus, data_focus, testing_focus, language_focus, physical_focus,
                          subject_id)
VALUES (2, 4, 0, 6, 10, 10, 0, 0, 0, 0, 0, 0, 123);
INSERT INTO public.focus (math_focus, logic_focus, programming_focus, design_focus, economics_focus, management_focus,
                          hardware_focus, network_focus, data_focus, testing_focus, language_focus, physical_focus,
                          subject_id)
VALUES (2, 4, 0, 6, 10, 10, 0, 0, 0, 0, 0, 0, 124);
INSERT INTO public.focus (math_focus, logic_focus, programming_focus, design_focus, economics_focus, management_focus,
                          hardware_focus, network_focus, data_focus, testing_focus, language_focus, physical_focus,
                          subject_id)
VALUES (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 125);
INSERT INTO public.focus (math_focus, logic_focus, programming_focus, design_focus, economics_focus, management_focus,
                          hardware_focus, network_focus, data_focus, testing_focus, language_focus, physical_focus,
                          subject_id)
VALUES (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 126);
INSERT INTO public.focus (math_focus, logic_focus, programming_focus, design_focus, economics_focus, management_focus,
                          hardware_focus, network_focus, data_focus, testing_focus, language_focus, physical_focus,
                          subject_id)
VALUES (8, 10, 5, 4, 0, 0, 0, 3, 5, 0, 0, 0, 127);
INSERT INTO public.focus (math_focus, logic_focus, programming_focus, design_focus, economics_focus, management_focus,
                          hardware_focus, network_focus, data_focus, testing_focus, language_focus, physical_focus,
                          subject_id)
VALUES (0, 10, 8, 6, 0, 4, 0, 2, 8, 0, 0, 0, 128);
INSERT INTO public.focus (math_focus, logic_focus, programming_focus, design_focus, economics_focus, management_focus,
                          hardware_focus, network_focus, data_focus, testing_focus, language_focus, physical_focus,
                          subject_id)
VALUES (9, 10, 0, 0, 4, 2, 0, 0, 10, 0, 0, 0, 129);
INSERT INTO public.focus (math_focus, logic_focus, programming_focus, design_focus, economics_focus, management_focus,
                          hardware_focus, network_focus, data_focus, testing_focus, language_focus, physical_focus,
                          subject_id)
VALUES (2, 10, 10, 3, 0, 0, 3, 0, 0, 8, 0, 0, 130);
INSERT INTO public.focus (math_focus, logic_focus, programming_focus, design_focus, economics_focus, management_focus,
                          hardware_focus, network_focus, data_focus, testing_focus, language_focus, physical_focus,
                          subject_id)
VALUES (10, 8, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 131);
INSERT INTO public.focus (math_focus, logic_focus, programming_focus, design_focus, economics_focus, management_focus,
                          hardware_focus, network_focus, data_focus, testing_focus, language_focus, physical_focus,
                          subject_id)
VALUES (0, 8, 10, 6, 0, 0, 0, 0, 0, 3, 0, 0, 132);
INSERT INTO public.focus (math_focus, logic_focus, programming_focus, design_focus, economics_focus, management_focus,
                          hardware_focus, network_focus, data_focus, testing_focus, language_focus, physical_focus,
                          subject_id)
VALUES (0, 7, 6, 2, 0, 0, 3, 10, 0, 0, 0, 0, 133);
INSERT INTO public.focus (math_focus, logic_focus, programming_focus, design_focus, economics_focus, management_focus,
                          hardware_focus, network_focus, data_focus, testing_focus, language_focus, physical_focus,
                          subject_id)
VALUES (0, 6, 3, 10, 0, 6, 0, 2, 0, 6, 0, 0, 134);
INSERT INTO public.focus (math_focus, logic_focus, programming_focus, design_focus, economics_focus, management_focus,
                          hardware_focus, network_focus, data_focus, testing_focus, language_focus, physical_focus,
                          subject_id)
VALUES (0, 8, 10, 6, 0, 0, 0, 0, 0, 3, 0, 0, 135);
INSERT INTO public.focus (math_focus, logic_focus, programming_focus, design_focus, economics_focus, management_focus,
                          hardware_focus, network_focus, data_focus, testing_focus, language_focus, physical_focus,
                          subject_id)
VALUES (9, 10, 0, 0, 4, 0, 0, 0, 10, 0, 0, 0, 136);
INSERT INTO public.focus (math_focus, logic_focus, programming_focus, design_focus, economics_focus, management_focus,
                          hardware_focus, network_focus, data_focus, testing_focus, language_focus, physical_focus,
                          subject_id)
VALUES (0, 6, 0, 4, 7, 10, 0, 0, 4, 0, 0, 0, 137);
INSERT INTO public.focus (math_focus, logic_focus, programming_focus, design_focus, economics_focus, management_focus,
                          hardware_focus, network_focus, data_focus, testing_focus, language_focus, physical_focus,
                          subject_id)
VALUES (0, 9, 10, 6, 0, 0, 0, 0, 3, 2, 0, 0, 138);
INSERT INTO public.focus (math_focus, logic_focus, programming_focus, design_focus, economics_focus, management_focus,
                          hardware_focus, network_focus, data_focus, testing_focus, language_focus, physical_focus,
                          subject_id)
VALUES (0, 4, 2, 8, 0, 0, 0, 0, 6, 0, 0, 0, 139);
INSERT INTO public.focus (math_focus, logic_focus, programming_focus, design_focus, economics_focus, management_focus,
                          hardware_focus, network_focus, data_focus, testing_focus, language_focus, physical_focus,
                          subject_id)
VALUES (0, 9, 10, 8, 0, 0, 0, 0, 2, 4, 0, 0, 140);
INSERT INTO public.focus (math_focus, logic_focus, programming_focus, design_focus, economics_focus, management_focus,
                          hardware_focus, network_focus, data_focus, testing_focus, language_focus, physical_focus,
                          subject_id)
VALUES (0, 7, 2, 0, 0, 8, 0, 0, 0, 0, 10, 0, 141);
INSERT INTO public.focus (math_focus, logic_focus, programming_focus, design_focus, economics_focus, management_focus,
                          hardware_focus, network_focus, data_focus, testing_focus, language_focus, physical_focus,
                          subject_id)
VALUES (2, 4, 0, 6, 10, 10, 0, 0, 0, 0, 0, 0, 142);
INSERT INTO public.focus (math_focus, logic_focus, programming_focus, design_focus, economics_focus, management_focus,
                          hardware_focus, network_focus, data_focus, testing_focus, language_focus, physical_focus,
                          subject_id)
VALUES (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 143);
INSERT INTO public.focus (math_focus, logic_focus, programming_focus, design_focus, economics_focus, management_focus,
                          hardware_focus, network_focus, data_focus, testing_focus, language_focus, physical_focus,
                          subject_id)
VALUES (5, 6, 0, 4, 0, 4, 0, 0, 6, 0, 0, 0, 144);
INSERT INTO public.focus (math_focus, logic_focus, programming_focus, design_focus, economics_focus, management_focus,
                          hardware_focus, network_focus, data_focus, testing_focus, language_focus, physical_focus,
                          subject_id)
VALUES (2, 4, 0, 8, 0, 4, 0, 0, 3, 0, 2, 0, 145);
INSERT INTO public.focus (math_focus, logic_focus, programming_focus, design_focus, economics_focus, management_focus,
                          hardware_focus, network_focus, data_focus, testing_focus, language_focus, physical_focus,
                          subject_id)
VALUES (5, 4, 0, 6, 10, 7, 0, 0, 3, 0, 0, 0, 146);
INSERT INTO public.focus (math_focus, logic_focus, programming_focus, design_focus, economics_focus, management_focus,
                          hardware_focus, network_focus, data_focus, testing_focus, language_focus, physical_focus,
                          subject_id)
VALUES (0, 9, 6, 0, 0, 0, 4, 6, 0, 0, 0, 0, 147);
INSERT INTO public.focus (math_focus, logic_focus, programming_focus, design_focus, economics_focus, management_focus,
                          hardware_focus, network_focus, data_focus, testing_focus, language_focus, physical_focus,
                          subject_id)
VALUES (0, 7, 2, 0, 0, 8, 0, 0, 0, 0, 10, 0, 148);
INSERT INTO public.focus (math_focus, logic_focus, programming_focus, design_focus, economics_focus, management_focus,
                          hardware_focus, network_focus, data_focus, testing_focus, language_focus, physical_focus,
                          subject_id)
VALUES (3, 9, 4, 7, 3, 5, 0, 0, 10, 6, 0, 0, 149);
INSERT INTO public.focus (math_focus, logic_focus, programming_focus, design_focus, economics_focus, management_focus,
                          hardware_focus, network_focus, data_focus, testing_focus, language_focus, physical_focus,
                          subject_id)
VALUES (0, 6, 3, 10, 0, 6, 0, 2, 0, 6, 0, 0, 150);
INSERT INTO public.focus (math_focus, logic_focus, programming_focus, design_focus, economics_focus, management_focus,
                          hardware_focus, network_focus, data_focus, testing_focus, language_focus, physical_focus,
                          subject_id)
VALUES (0, 8, 10, 8, 0, 0, 0, 0, 0, 7, 0, 0, 151);
INSERT INTO public.focus (math_focus, logic_focus, programming_focus, design_focus, economics_focus, management_focus,
                          hardware_focus, network_focus, data_focus, testing_focus, language_focus, physical_focus,
                          subject_id)
VALUES (3, 6, 4, 5, 2, 5, 0, 0, 10, 6, 0, 0, 152);
INSERT INTO public.focus (math_focus, logic_focus, programming_focus, design_focus, economics_focus, management_focus,
                          hardware_focus, network_focus, data_focus, testing_focus, language_focus, physical_focus,
                          subject_id)
VALUES (0, 7, 6, 2, 0, 0, 3, 10, 0, 0, 0, 0, 153);
INSERT INTO public.focus (math_focus, logic_focus, programming_focus, design_focus, economics_focus, management_focus,
                          hardware_focus, network_focus, data_focus, testing_focus, language_focus, physical_focus,
                          subject_id)
VALUES (6, 8, 5, 2, 6, 3, 0, 0, 10, 0, 0, 0, 154);
INSERT INTO public.focus (math_focus, logic_focus, programming_focus, design_focus, economics_focus, management_focus,
                          hardware_focus, network_focus, data_focus, testing_focus, language_focus, physical_focus,
                          subject_id)
VALUES (10, 8, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, 155);
INSERT INTO public.focus (math_focus, logic_focus, programming_focus, design_focus, economics_focus, management_focus,
                          hardware_focus, network_focus, data_focus, testing_focus, language_focus, physical_focus,
                          subject_id)
VALUES (0, 6, 10, 0, 0, 0, 0, 10, 6, 5, 0, 0, 156);
INSERT INTO public.focus (math_focus, logic_focus, programming_focus, design_focus, economics_focus, management_focus,
                          hardware_focus, network_focus, data_focus, testing_focus, language_focus, physical_focus,
                          subject_id)
VALUES (0, 5, 2, 3, 2, 0, 10, 2, 0, 0, 0, 0, 157);
INSERT INTO public.focus (math_focus, logic_focus, programming_focus, design_focus, economics_focus, management_focus,
                          hardware_focus, network_focus, data_focus, testing_focus, language_focus, physical_focus,
                          subject_id)
VALUES (0, 9, 10, 8, 0, 0, 0, 0, 2, 4, 0, 0, 158);
INSERT INTO public.focus (math_focus, logic_focus, programming_focus, design_focus, economics_focus, management_focus,
                          hardware_focus, network_focus, data_focus, testing_focus, language_focus, physical_focus,
                          subject_id)
VALUES (0, 8, 2, 0, 0, 0, 0, 10, 2, 6, 0, 0, 159);
INSERT INTO public.focus (math_focus, logic_focus, programming_focus, design_focus, economics_focus, management_focus,
                          hardware_focus, network_focus, data_focus, testing_focus, language_focus, physical_focus,
                          subject_id)
VALUES (0, 8, 8, 0, 0, 0, 4, 7, 0, 0, 0, 0, 160);
INSERT INTO public.focus (math_focus, logic_focus, programming_focus, design_focus, economics_focus, management_focus,
                          hardware_focus, network_focus, data_focus, testing_focus, language_focus, physical_focus,
                          subject_id)
VALUES (0, 4, 7, 0, 0, 0, 0, 0, 0, 10, 0, 0, 161);
INSERT INTO public.focus (math_focus, logic_focus, programming_focus, design_focus, economics_focus, management_focus,
                          hardware_focus, network_focus, data_focus, testing_focus, language_focus, physical_focus,
                          subject_id)
VALUES (5, 4, 0, 6, 10, 7, 0, 0, 3, 0, 0, 0, 162);
INSERT INTO public.focus (math_focus, logic_focus, programming_focus, design_focus, economics_focus, management_focus,
                          hardware_focus, network_focus, data_focus, testing_focus, language_focus, physical_focus,
                          subject_id)
VALUES (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 163);
INSERT INTO public.focus (math_focus, logic_focus, programming_focus, design_focus, economics_focus, management_focus,
                          hardware_focus, network_focus, data_focus, testing_focus, language_focus, physical_focus,
                          subject_id)
VALUES (0, 8, 8, 7, 0, 0, 9, 10, 0, 3, 0, 0, 164);
INSERT INTO public.focus (math_focus, logic_focus, programming_focus, design_focus, economics_focus, management_focus,
                          hardware_focus, network_focus, data_focus, testing_focus, language_focus, physical_focus,
                          subject_id)
VALUES (8, 6, 0, 2, 10, 9, 0, 0, 6, 0, 0, 0, 165);
INSERT INTO public.focus (math_focus, logic_focus, programming_focus, design_focus, economics_focus, management_focus,
                          hardware_focus, network_focus, data_focus, testing_focus, language_focus, physical_focus,
                          subject_id)
VALUES (2, 4, 0, 6, 10, 10, 0, 0, 4, 0, 0, 0, 166);
INSERT INTO public.focus (math_focus, logic_focus, programming_focus, design_focus, economics_focus, management_focus,
                          hardware_focus, network_focus, data_focus, testing_focus, language_focus, physical_focus,
                          subject_id)
VALUES (0, 7, 2, 0, 0, 8, 0, 0, 0, 0, 10, 0, 167);
INSERT INTO public.focus (math_focus, logic_focus, programming_focus, design_focus, economics_focus, management_focus,
                          hardware_focus, network_focus, data_focus, testing_focus, language_focus, physical_focus,
                          subject_id)
VALUES (5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 168);
INSERT INTO public.focus (math_focus, logic_focus, programming_focus, design_focus, economics_focus, management_focus,
                          hardware_focus, network_focus, data_focus, testing_focus, language_focus, physical_focus,
                          subject_id)
VALUES (5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 169);
INSERT INTO public.focus (math_focus, logic_focus, programming_focus, design_focus, economics_focus, management_focus,
                          hardware_focus, network_focus, data_focus, testing_focus, language_focus, physical_focus,
                          subject_id)
VALUES (7, 9, 3, 0, 7, 0, 0, 0, 10, 5, 0, 0, 170);
INSERT INTO public.focus (math_focus, logic_focus, programming_focus, design_focus, economics_focus, management_focus,
                          hardware_focus, network_focus, data_focus, testing_focus, language_focus, physical_focus,
                          subject_id)
VALUES (0, 8, 8, 0, 0, 0, 4, 7, 0, 0, 0, 0, 171);
INSERT INTO public.focus (math_focus, logic_focus, programming_focus, design_focus, economics_focus, management_focus,
                          hardware_focus, network_focus, data_focus, testing_focus, language_focus, physical_focus,
                          subject_id)
VALUES (3, 8, 8, 8, 0, 0, 0, 0, 0, 4, 0, 0, 172);
INSERT INTO public.focus (math_focus, logic_focus, programming_focus, design_focus, economics_focus, management_focus,
                          hardware_focus, network_focus, data_focus, testing_focus, language_focus, physical_focus,
                          subject_id)
VALUES (0, 10, 9, 6, 0, 0, 4, 8, 0, 4, 0, 0, 173);
INSERT INTO public.focus (math_focus, logic_focus, programming_focus, design_focus, economics_focus, management_focus,
                          hardware_focus, network_focus, data_focus, testing_focus, language_focus, physical_focus,
                          subject_id)
VALUES (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 10, 174);
INSERT INTO public.focus (math_focus, logic_focus, programming_focus, design_focus, economics_focus, management_focus,
                          hardware_focus, network_focus, data_focus, testing_focus, language_focus, physical_focus,
                          subject_id)
VALUES (0, 4, 0, 4, 0, 10, 0, 0, 0, 0, 8, 0, 175);

-- Subject grades

INSERT INTO public.subject_grades (subject_id, grade_a, grade_b, grade_c, grade_d, grade_e, grade_fx, students_count,
                                   grade_average)
VALUES ((SELECT subject_id FROM public.subject WHERE code = '6BI0021'), 0.00, 0.00, 5.88, 0.00, 8.82, 85.29, 34,
        5.7348);
INSERT INTO public.subject_grades (subject_id, grade_a, grade_b, grade_c, grade_d, grade_e, grade_fx, students_count,
                                   grade_average)
VALUES ((SELECT subject_id FROM public.subject WHERE code = '6BI0011'), 3.10, 7.36, 6.98, 14.34, 19.19, 49.03, 516,
        4.8625);
INSERT INTO public.subject_grades (subject_id, grade_a, grade_b, grade_c, grade_d, grade_e, grade_fx, students_count,
                                   grade_average)
VALUES ((SELECT subject_id FROM public.subject WHERE code = '6BI0038'), 5.43, 4.35, 8.70, 20.65, 33.70, 27.17, 92,
        4.5435);
INSERT INTO public.subject_grades (subject_id, grade_a, grade_b, grade_c, grade_d, grade_e, grade_fx, students_count,
                                   grade_average)
VALUES ((SELECT subject_id FROM public.subject WHERE code = '6BA0010'), 2.08, 5.21, 13.54, 35.42, 16.67, 27.08, 96,
        4.4063);
INSERT INTO public.subject_grades (subject_id, grade_a, grade_b, grade_c, grade_d, grade_e, grade_fx, students_count,
                                   grade_average)
VALUES ((SELECT subject_id FROM public.subject WHERE code = '6BA0004'), 10.81, 2.70, 21.62, 16.22, 10.81, 37.84, 37,
        4.2704);
INSERT INTO public.subject_grades (subject_id, grade_a, grade_b, grade_c, grade_d, grade_e, grade_fx, students_count,
                                   grade_average)
VALUES ((SELECT subject_id FROM public.subject WHERE code = '6BA0006'), 8.54, 5.38, 11.39, 14.87, 48.42, 11.39, 316,
        4.2339);
INSERT INTO public.subject_grades (subject_id, grade_a, grade_b, grade_c, grade_d, grade_e, grade_fx, students_count,
                                   grade_average)
VALUES ((SELECT subject_id FROM public.subject WHERE code = '6BL0001'), 2.65, 5.30, 19.21, 33.11, 26.49, 13.25, 151,
        4.152699999999999);
INSERT INTO public.subject_grades (subject_id, grade_a, grade_b, grade_c, grade_d, grade_e, grade_fx, students_count,
                                   grade_average)
VALUES ((SELECT subject_id FROM public.subject WHERE code = '6UM0002'), 4.76, 14.29, 14.29, 23.81, 28.57, 14.29, 21,
        4.0004);
INSERT INTO public.subject_grades (subject_id, grade_a, grade_b, grade_c, grade_d, grade_e, grade_fx, students_count,
                                   grade_average)
VALUES ((SELECT subject_id FROM public.subject WHERE code = '6UI0012'), 5.83, 3.33, 20.83, 30.00, 37.50, 2.50, 120,
        3.9748);
INSERT INTO public.subject_grades (subject_id, grade_a, grade_b, grade_c, grade_d, grade_e, grade_fx, students_count,
                                   grade_average)
VALUES ((SELECT subject_id FROM public.subject WHERE code = '6BI0034'), 5.86, 12.55, 18.83, 17.57, 33.89, 11.30, 239,
        3.9498);
INSERT INTO public.subject_grades (subject_id, grade_a, grade_b, grade_c, grade_d, grade_e, grade_fx, students_count,
                                   grade_average)
VALUES ((SELECT subject_id FROM public.subject WHERE code = '6UA0001'), 13.08, 11.21, 14.02, 15.89, 29.91, 15.89, 107,
        3.8601000000000005);
INSERT INTO public.subject_grades (subject_id, grade_a, grade_b, grade_c, grade_d, grade_e, grade_fx, students_count,
                                   grade_average)
VALUES ((SELECT subject_id FROM public.subject WHERE code = '6UA0002'), 16.28, 5.43, 14.73, 17.83, 35.66, 10.08, 129,
        3.8142999999999994);
INSERT INTO public.subject_grades (subject_id, grade_a, grade_b, grade_c, grade_d, grade_e, grade_fx, students_count,
                                   grade_average)
VALUES ((SELECT subject_id FROM public.subject WHERE code = '6BA0001'), 12.58, 9.20, 15.34, 22.70, 30.37, 9.82, 326,
        3.7857);
INSERT INTO public.subject_grades (subject_id, grade_a, grade_b, grade_c, grade_d, grade_e, grade_fx, students_count,
                                   grade_average)
VALUES ((SELECT subject_id FROM public.subject WHERE code = '6BI0012'), 8.70, 8.70, 21.74, 23.91, 30.43, 6.52, 46,
        3.7823);
INSERT INTO public.subject_grades (subject_id, grade_a, grade_b, grade_c, grade_d, grade_e, grade_fx, students_count,
                                   grade_average)
VALUES ((SELECT subject_id FROM public.subject WHERE code = '6BI0005'), 4.41, 4.41, 44.12, 22.06, 8.82, 16.18, 68,
        3.7500999999999998);
INSERT INTO public.subject_grades (subject_id, grade_a, grade_b, grade_c, grade_d, grade_e, grade_fx, students_count,
                                   grade_average)
VALUES ((SELECT subject_id FROM public.subject WHERE code = '6BA0009'), 7.50, 15.62, 20.00, 23.44, 18.75, 14.69, 320,
        3.7439);
INSERT INTO public.subject_grades (subject_id, grade_a, grade_b, grade_c, grade_d, grade_e, grade_fx, students_count,
                                   grade_average)
VALUES ((SELECT subject_id FROM public.subject WHERE code = '6UI0004'), 1.89, 16.98, 26.42, 30.19, 15.09, 9.43, 53,
        3.6790000000000003);
INSERT INTO public.subject_grades (subject_id, grade_a, grade_b, grade_c, grade_d, grade_e, grade_fx, students_count,
                                   grade_average)
VALUES ((SELECT subject_id FROM public.subject WHERE code = '6BT0007'), 46.88, 0.00, 0.00, 0.00, 0.00, 53.12, 64,
        3.6559999999999997);
INSERT INTO public.subject_grades (subject_id, grade_a, grade_b, grade_c, grade_d, grade_e, grade_fx, students_count,
                                   grade_average)
VALUES ((SELECT subject_id FROM public.subject WHERE code = '6BI0026'), 11.76, 13.24, 19.12, 24.26, 22.06, 9.56, 136,
        3.603);
INSERT INTO public.subject_grades (subject_id, grade_a, grade_b, grade_c, grade_d, grade_e, grade_fx, students_count,
                                   grade_average)
VALUES ((SELECT subject_id FROM public.subject WHERE code = '6BI0016'), 6.67, 13.33, 20.00, 33.33, 26.67, 0.00, 15,
        3.6);
INSERT INTO public.subject_grades (subject_id, grade_a, grade_b, grade_c, grade_d, grade_e, grade_fx, students_count,
                                   grade_average)
VALUES ((SELECT subject_id FROM public.subject WHERE code = '6BA0008'), 23.08, 7.69, 15.38, 7.69, 38.46, 7.69, 13,
        3.5380000000000003);
INSERT INTO public.subject_grades (subject_id, grade_a, grade_b, grade_c, grade_d, grade_e, grade_fx, students_count,
                                   grade_average)
VALUES ((SELECT subject_id FROM public.subject WHERE code = '6BI0035'), 3.82, 14.01, 33.12, 29.94, 13.38, 5.73, 157,
        3.5224);
INSERT INTO public.subject_grades (subject_id, grade_a, grade_b, grade_c, grade_d, grade_e, grade_fx, students_count,
                                   grade_average)
VALUES ((SELECT subject_id FROM public.subject WHERE code = '6BI0046'), 9.68, 16.13, 16.13, 38.71, 12.90, 6.45, 31,
        3.4837000000000002);
INSERT INTO public.subject_grades (subject_id, grade_a, grade_b, grade_c, grade_d, grade_e, grade_fx, students_count,
                                   grade_average)
VALUES ((SELECT subject_id FROM public.subject WHERE code = '6BI0027'), 21.74, 14.49, 11.59, 15.94, 18.84, 17.39, 69,
        3.4779);
INSERT INTO public.subject_grades (subject_id, grade_a, grade_b, grade_c, grade_d, grade_e, grade_fx, students_count,
                                   grade_average)
VALUES ((SELECT subject_id FROM public.subject WHERE code = '6BI0055'), 11.48, 13.93, 25.41, 27.05, 9.02, 13.11, 122,
        3.4753);
INSERT INTO public.subject_grades (subject_id, grade_a, grade_b, grade_c, grade_d, grade_e, grade_fx, students_count,
                                   grade_average)
VALUES ((SELECT subject_id FROM public.subject WHERE code = '6UI0010'), 7.49, 11.73, 32.57, 27.69, 15.31, 5.21, 307,
        3.4723);
INSERT INTO public.subject_grades (subject_id, grade_a, grade_b, grade_c, grade_d, grade_e, grade_fx, students_count,
                                   grade_average)
VALUES ((SELECT subject_id FROM public.subject WHERE code = '6BI0039'), 21.76, 11.92, 16.58, 11.40, 23.83, 14.51, 193,
        3.4715);
INSERT INTO public.subject_grades (subject_id, grade_a, grade_b, grade_c, grade_d, grade_e, grade_fx, students_count,
                                   grade_average)
VALUES ((SELECT subject_id FROM public.subject WHERE code = '6BM0020'), 20.29, 18.84, 20.29, 5.80, 7.25, 27.54, 69,
        3.4353000000000002);
INSERT INTO public.subject_grades (subject_id, grade_a, grade_b, grade_c, grade_d, grade_e, grade_fx, students_count,
                                   grade_average)
VALUES ((SELECT subject_id FROM public.subject WHERE code = '6UM0004'), 16.28, 13.95, 20.93, 23.26, 11.63, 13.95, 43,
        3.4186);
INSERT INTO public.subject_grades (subject_id, grade_a, grade_b, grade_c, grade_d, grade_e, grade_fx, students_count,
                                   grade_average)
VALUES ((SELECT subject_id FROM public.subject WHERE code = '6BI0041'), 0.00, 0.00, 66.67, 33.33, 0.00, 0.00, 3,
        3.3333);
INSERT INTO public.subject_grades (subject_id, grade_a, grade_b, grade_c, grade_d, grade_e, grade_fx, students_count,
                                   grade_average)
VALUES ((SELECT subject_id FROM public.subject WHERE code = '6BI0040'), 16.88, 7.79, 18.18, 40.26, 16.88, 0.00, 77,
        3.3244);
INSERT INTO public.subject_grades (subject_id, grade_a, grade_b, grade_c, grade_d, grade_e, grade_fx, students_count,
                                   grade_average)
VALUES ((SELECT subject_id FROM public.subject WHERE code = '6UI0002'), 22.73, 9.09, 13.64, 22.73, 31.82, 0.00, 22,
        3.3185000000000002);
INSERT INTO public.subject_grades (subject_id, grade_a, grade_b, grade_c, grade_d, grade_e, grade_fx, students_count,
                                   grade_average)
VALUES ((SELECT subject_id FROM public.subject WHERE code = '6BI0042'), 30.77, 15.38, 7.69, 7.69, 15.38, 23.08, 13,
        3.3074);
INSERT INTO public.subject_grades (subject_id, grade_a, grade_b, grade_c, grade_d, grade_e, grade_fx, students_count,
                                   grade_average)
VALUES ((SELECT subject_id FROM public.subject WHERE code = '6UI0005'), 7.14, 17.86, 30.95, 29.76, 10.71, 3.57, 84,
        3.2972);
INSERT INTO public.subject_grades (subject_id, grade_a, grade_b, grade_c, grade_d, grade_e, grade_fx, students_count,
                                   grade_average)
VALUES ((SELECT subject_id FROM public.subject WHERE code = '6UM0007'), 13.48, 16.85, 19.10, 34.83, 11.24, 4.49, 89,
        3.2694);
INSERT INTO public.subject_grades (subject_id, grade_a, grade_b, grade_c, grade_d, grade_e, grade_fx, students_count,
                                   grade_average)
VALUES ((SELECT subject_id FROM public.subject WHERE code = '6BA0005'), 8.90, 22.51, 31.41, 15.18, 15.18, 6.81, 191,
        3.2563);
INSERT INTO public.subject_grades (subject_id, grade_a, grade_b, grade_c, grade_d, grade_e, grade_fx, students_count,
                                   grade_average)
VALUES ((SELECT subject_id FROM public.subject WHERE code = '6BJ0005'), 5.33, 25.00, 31.97, 23.77, 8.20, 5.74, 244,
        3.2176);
INSERT INTO public.subject_grades (subject_id, grade_a, grade_b, grade_c, grade_d, grade_e, grade_fx, students_count,
                                   grade_average)
VALUES ((SELECT subject_id FROM public.subject WHERE code = '6BI0028'), 8.70, 20.29, 34.78, 15.94, 18.84, 1.45, 69,
        3.2028);
INSERT INTO public.subject_grades (subject_id, grade_a, grade_b, grade_c, grade_d, grade_e, grade_fx, students_count,
                                   grade_average)
VALUES ((SELECT subject_id FROM public.subject WHERE code = '6BA0002'), 19.84, 15.87, 23.02, 15.08, 20.63, 5.56, 126,
        3.1746999999999996);
INSERT INTO public.subject_grades (subject_id, grade_a, grade_b, grade_c, grade_d, grade_e, grade_fx, students_count,
                                   grade_average)
VALUES ((SELECT subject_id FROM public.subject WHERE code = '6UA0003'), 10.93, 21.31, 30.05, 21.86, 10.93, 4.92, 183,
        3.1531000000000002);
INSERT INTO public.subject_grades (subject_id, grade_a, grade_b, grade_c, grade_d, grade_e, grade_fx, students_count,
                                   grade_average)
VALUES ((SELECT subject_id FROM public.subject WHERE code = '6BJ0006'), 11.92, 21.85, 27.15, 22.52, 12.58, 3.97, 151,
        3.1387);
INSERT INTO public.subject_grades (subject_id, grade_a, grade_b, grade_c, grade_d, grade_e, grade_fx, students_count,
                                   grade_average)
VALUES ((SELECT subject_id FROM public.subject WHERE code = '6BM0019'), 22.97, 27.03, 12.16, 6.76, 16.22, 14.86, 74,
        3.1081);
INSERT INTO public.subject_grades (subject_id, grade_a, grade_b, grade_c, grade_d, grade_e, grade_fx, students_count,
                                   grade_average)
VALUES ((SELECT subject_id FROM public.subject WHERE code = '6BM0027'), 21.03, 13.10, 29.37, 18.25, 11.90, 6.35, 252,
        3.0594);
INSERT INTO public.subject_grades (subject_id, grade_a, grade_b, grade_c, grade_d, grade_e, grade_fx, students_count,
                                   grade_average)
VALUES ((SELECT subject_id FROM public.subject WHERE code = '6UM0005'), 11.76, 23.53, 29.41, 17.65, 17.65, 0.00, 17,
        3.0589999999999997);
INSERT INTO public.subject_grades (subject_id, grade_a, grade_b, grade_c, grade_d, grade_e, grade_fx, students_count,
                                   grade_average)
VALUES ((SELECT subject_id FROM public.subject WHERE code = '6BI0003'), 9.09, 18.79, 39.39, 26.67, 6.06, 0.00, 165,
        3.0181999999999998);
INSERT INTO public.subject_grades (subject_id, grade_a, grade_b, grade_c, grade_d, grade_e, grade_fx, students_count,
                                   grade_average)
VALUES ((SELECT subject_id FROM public.subject WHERE code = '6BZ0001'), 0.00, 0.00, 100.00, 0.00, 0.00, 0.00, 1, 3.0);
INSERT INTO public.subject_grades (subject_id, grade_a, grade_b, grade_c, grade_d, grade_e, grade_fx, students_count,
                                   grade_average)
VALUES ((SELECT subject_id FROM public.subject WHERE code = '6BI0050'), 25.00, 37.50, 0.00, 12.50, 0.00, 25.00, 8, 3.0);
INSERT INTO public.subject_grades (subject_id, grade_a, grade_b, grade_c, grade_d, grade_e, grade_fx, students_count,
                                   grade_average)
VALUES ((SELECT subject_id FROM public.subject WHERE code = '6BI0013'), 28.47, 13.17, 16.01, 21.00, 20.64, 0.71, 281,
        2.943);
INSERT INTO public.subject_grades (subject_id, grade_a, grade_b, grade_c, grade_d, grade_e, grade_fx, students_count,
                                   grade_average)
VALUES ((SELECT subject_id FROM public.subject WHERE code = '6BH0003'), 15.44, 23.54, 32.66, 16.71, 8.61, 3.04, 395,
        2.8863);
INSERT INTO public.subject_grades (subject_id, grade_a, grade_b, grade_c, grade_d, grade_e, grade_fx, students_count,
                                   grade_average)
VALUES ((SELECT subject_id FROM public.subject WHERE code = '6BI0001'), 27.33, 19.77, 16.86, 15.12, 18.31, 2.62, 344,
        2.852);
INSERT INTO public.subject_grades (subject_id, grade_a, grade_b, grade_c, grade_d, grade_e, grade_fx, students_count,
                                   grade_average)
VALUES ((SELECT subject_id FROM public.subject WHERE code = '6BI0048'), 30.00, 16.67, 13.33, 26.67, 6.67, 6.67, 30,
        2.8338);
INSERT INTO public.subject_grades (subject_id, grade_a, grade_b, grade_c, grade_d, grade_e, grade_fx, students_count,
                                   grade_average)
VALUES ((SELECT subject_id FROM public.subject WHERE code = '6BA0011'), 10.00, 60.00, 10.00, 0.00, 0.00, 20.00, 10,
        2.8);
INSERT INTO public.subject_grades (subject_id, grade_a, grade_b, grade_c, grade_d, grade_e, grade_fx, students_count,
                                   grade_average)
VALUES ((SELECT subject_id FROM public.subject WHERE code = '6BI0019'), 30.41, 17.97, 21.20, 11.98, 17.05, 1.38, 217,
        2.714);;
INSERT INTO public.subject_grades (subject_id, grade_a, grade_b, grade_c, grade_d, grade_e, grade_fx, students_count,
                                   grade_average)
VALUES ((SELECT subject_id FROM public.subject WHERE code = '6BJ0001'), 21.77, 33.58, 27.31, 15.13, 1.48, 0.74, 271,
        2.4322);
INSERT INTO public.subject_grades (subject_id, grade_a, grade_b, grade_c, grade_d, grade_e, grade_fx, students_count,
                                   grade_average)
VALUES ((SELECT subject_id FROM public.subject WHERE code = '6BI0032'), 31.91, 28.72, 17.02, 12.77, 8.51, 1.06, 94,
        2.404);
INSERT INTO public.subject_grades (subject_id, grade_a, grade_b, grade_c, grade_d, grade_e, grade_fx, students_count,
                                   grade_average)
VALUES ((SELECT subject_id FROM public.subject WHERE code = '6BA0012'), 51.69, 15.25, 10.59, 4.66, 10.59, 7.20, 236,
        2.2875);
INSERT INTO public.subject_grades (subject_id, grade_a, grade_b, grade_c, grade_d, grade_e, grade_fx, students_count,
                                   grade_average)
VALUES ((SELECT subject_id FROM public.subject WHERE code = '6BA0007'), 41.67, 25.00, 12.50, 10.42, 6.25, 4.17, 48,
        2.2712);
INSERT INTO public.subject_grades (subject_id, grade_a, grade_b, grade_c, grade_d, grade_e, grade_fx, students_count,
                                   grade_average)
VALUES ((SELECT subject_id FROM public.subject WHERE code = '6BI0033'), 40.00, 24.00, 20.00, 6.00, 6.00, 4.00, 50,
        2.26);
INSERT INTO public.subject_grades (subject_id, grade_a, grade_b, grade_c, grade_d, grade_e, grade_fx, students_count,
                                   grade_average)
VALUES ((SELECT subject_id FROM public.subject WHERE code = '6BH0002'), 42.22, 22.22, 20.00, 2.22, 11.11, 2.22, 45,
        2.2441);
INSERT INTO public.subject_grades (subject_id, grade_a, grade_b, grade_c, grade_d, grade_e, grade_fx, students_count,
                                   grade_average)
VALUES ((SELECT subject_id FROM public.subject WHERE code = '6UI0006'), 40.74, 29.63, 14.81, 3.70, 3.70, 7.41, 27,
        2.2218999999999998);
INSERT INTO public.subject_grades (subject_id, grade_a, grade_b, grade_c, grade_d, grade_e, grade_fx, students_count,
                                   grade_average)
VALUES ((SELECT subject_id FROM public.subject WHERE code = '6BA0013'), 48.00, 20.00, 8.00, 20.00, 4.00, 0.00, 25,
        2.12);
INSERT INTO public.subject_grades (subject_id, grade_a, grade_b, grade_c, grade_d, grade_e, grade_fx, students_count,
                                   grade_average)
VALUES ((SELECT subject_id FROM public.subject WHERE code = '6BJ0002'), 34.71, 36.36, 19.42, 4.96, 0.83, 3.72, 242,
        2.12);
INSERT INTO public.subject_grades (subject_id, grade_a, grade_b, grade_c, grade_d, grade_e, grade_fx, students_count,
                                   grade_average)
VALUES ((SELECT subject_id FROM public.subject WHERE code = '6BI0049'), 0.00, 100.00, 0.00, 0.00, 0.00, 0.00, 1, 2.0);
INSERT INTO public.subject_grades (subject_id, grade_a, grade_b, grade_c, grade_d, grade_e, grade_fx, students_count,
                                   grade_average)
VALUES ((SELECT subject_id FROM public.subject WHERE code = '6BA0014'), 28.07, 54.39, 15.79, 0.00, 1.75, 0.00, 57,
        1.9297);
INSERT INTO public.subject_grades (subject_id, grade_a, grade_b, grade_c, grade_d, grade_e, grade_fx, students_count,
                                   grade_average)
VALUES ((SELECT subject_id FROM public.subject WHERE code = '6BI0024'), 61.54, 15.38, 7.69, 7.69, 7.69, 0.00, 13,
        1.8458);
INSERT INTO public.subject_grades (subject_id, grade_a, grade_b, grade_c, grade_d, grade_e, grade_fx, students_count,
                                   grade_average)
VALUES ((SELECT subject_id FROM public.subject WHERE code = '6BM0003'), 69.70, 18.18, 0.00, 3.03, 0.00, 9.09, 33,
        1.7272);
INSERT INTO public.subject_grades (subject_id, grade_a, grade_b, grade_c, grade_d, grade_e, grade_fx, students_count,
                                   grade_average)
VALUES ((SELECT subject_id FROM public.subject WHERE code = '6BI0037'), 76.19, 2.38, 5.95, 7.14, 7.14, 1.19, 84, 1.702);
INSERT INTO public.subject_grades (subject_id, grade_a, grade_b, grade_c, grade_d, grade_e, grade_fx, students_count,
                                   grade_average)
VALUES ((SELECT subject_id FROM public.subject WHERE code = '6BI0009'), 68.42, 21.05, 0.00, 5.26, 0.00, 5.26, 19,
        1.6312);
INSERT INTO public.subject_grades (subject_id, grade_a, grade_b, grade_c, grade_d, grade_e, grade_fx, students_count,
                                   grade_average)
VALUES ((SELECT subject_id FROM public.subject WHERE code = '6BI0045'), 67.27, 18.18, 3.64, 7.27, 3.64, 0.00, 55,
        1.6182999999999998);
INSERT INTO public.subject_grades (subject_id, grade_a, grade_b, grade_c, grade_d, grade_e, grade_fx, students_count,
                                   grade_average)
VALUES ((SELECT subject_id FROM public.subject WHERE code = '6BI0054'), 57.14, 42.86, 0.00, 0.00, 0.00, 0.00, 7,
        1.4286);
INSERT INTO public.subject_grades (subject_id, grade_a, grade_b, grade_c, grade_d, grade_e, grade_fx, students_count,
                                   grade_average)
VALUES ((SELECT subject_id FROM public.subject WHERE code = '6BI0023'), 72.73, 22.73, 0.00, 0.00, 4.55, 0.00, 22,
        1.4094);
INSERT INTO public.subject_grades (subject_id, grade_a, grade_b, grade_c, grade_d, grade_e, grade_fx, students_count,
                                   grade_average)
VALUES ((SELECT subject_id FROM public.subject WHERE code = '6BI0018'), 81.16, 14.01, 3.86, 0.97, 0.00, 0.00, 207,
        1.2464);
INSERT INTO public.subject_grades (subject_id, grade_a, grade_b, grade_c, grade_d, grade_e, grade_fx, students_count,
                                   grade_average)
VALUES ((SELECT subject_id FROM public.subject WHERE code = '6BT0001'), 96.12, 0.97, 0.00, 0.49, 0.49, 1.94, 206,
        1.1411);
INSERT INTO public.subject_grades (subject_id, grade_a, grade_b, grade_c, grade_d, grade_e, grade_fx, students_count,
                                   grade_average)
VALUES ((SELECT subject_id FROM public.subject WHERE code = '6BI0007'), 90.71, 6.56, 2.73, 0.00, 0.00, 0.00, 183,
        1.1201999999999999);
INSERT INTO public.subject_grades (subject_id, grade_a, grade_b, grade_c, grade_d, grade_e, grade_fx, students_count,
                                   grade_average)
VALUES ((SELECT subject_id FROM public.subject WHERE code = '6BT0003'), 97.27, 0.00, 0.45, 0.45, 0.00, 1.82, 220,
        1.1134);
INSERT INTO public.subject_grades (subject_id, grade_a, grade_b, grade_c, grade_d, grade_e, grade_fx, students_count,
                                   grade_average)
VALUES ((SELECT subject_id FROM public.subject WHERE code = '6BT0005'), 98.03, 0.00, 0.00, 0.00, 0.00, 1.97, 152,
        1.0985);
INSERT INTO public.subject_grades (subject_id, grade_a, grade_b, grade_c, grade_d, grade_e, grade_fx, students_count,
                                   grade_average)
VALUES ((SELECT subject_id FROM public.subject WHERE code = '6BT0006'), 98.33, 0.83, 0.00, 0.00, 0.00, 0.83, 120,
        1.0497);
INSERT INTO public.subject_grades (subject_id, grade_a, grade_b, grade_c, grade_d, grade_e, grade_fx, students_count,
                                   grade_average)
VALUES ((SELECT subject_id FROM public.subject WHERE code = '6BT0002'), 97.96, 1.36, 0.00, 0.00, 0.00, 0.68, 147,
        1.0475999999999999);
INSERT INTO public.subject_grades (subject_id, grade_a, grade_b, grade_c, grade_d, grade_e, grade_fx, students_count,
                                   grade_average)
VALUES ((SELECT subject_id FROM public.subject WHERE code = '6UI0007'), 99.20, 0.00, 0.80, 0.00, 0.00, 0.00, 125,
        1.016);
INSERT INTO public.subject_grades (subject_id, grade_a, grade_b, grade_c, grade_d, grade_e, grade_fx, students_count,
                                   grade_average)
VALUES ((SELECT subject_id FROM public.subject WHERE code = '6BT0004'), 99.32, 0.68, 0.00, 0.00, 0.00, 0.00, 148,
        1.0068);
INSERT INTO public.subject_grades (subject_id, grade_a, grade_b, grade_c, grade_d, grade_e, grade_fx, students_count,
                                   grade_average)
VALUES ((SELECT subject_id FROM public.subject WHERE code = '6BT0008'), 100.00, 0.00, 0.00, 0.00, 0.00, 0.00, 13, 1.0);
INSERT INTO public.subject_grades (subject_id, grade_a, grade_b, grade_c, grade_d, grade_e, grade_fx, students_count,
                                   grade_average)
VALUES ((SELECT subject_id FROM public.subject WHERE code = '6BX0001'), 100.00, 0.00, 0.00, 0.00, 0.00, 0.00, 309, 1.0);
INSERT INTO public.subject_grades (subject_id, grade_a, grade_b, grade_c, grade_d, grade_e, grade_fx, students_count,
                                   grade_average)
VALUES ((SELECT subject_id FROM public.subject WHERE code = '6BI0052'), 100.00, 0.00, 0.00, 0.00, 0.00, 0.00, 31, 1.0);
INSERT INTO public.subject_grades (subject_id, grade_a, grade_b, grade_c, grade_d, grade_e, grade_fx, students_count,
                                   grade_average)
VALUES ((SELECT subject_id FROM public.subject WHERE code = '6BM0029'), 0, 0, 0, 0, 0, 0, 0, 0.0);
INSERT INTO public.subject_grades (subject_id, grade_a, grade_b, grade_c, grade_d, grade_e, grade_fx, students_count,
                                   grade_average)
VALUES ((SELECT subject_id FROM public.subject WHERE code = '6BA0003'), 0, 0, 0, 0, 0, 0, 0, 0.0);



