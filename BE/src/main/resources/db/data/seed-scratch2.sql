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
INSERT INTO public.role (role_id, name) VALUES (4, 'vedenie');
INSERT INTO public.role (role_id, name) VALUES (5, 'admin');

INSERT INTO public.study_program (study_program_id, name) VALUES (3, 'informatika');

INSERT INTO public."user" (user_id, role_id, email, first_name, last_name, password) VALUES (1, 1, 'nagy1@stud.uniza.sk', 'Adam', 'Nagy', '$2a$10$FWZ7zGzeQGdlMX3Bd.nTTOYyY0n8GtsGdgq53a414w65OPHgOv8Me');
INSERT INTO public."user" (user_id, role_id, email, first_name, last_name, password) VALUES (2, 1, 'majba@stud.uniza.sk', 'Maroš', 'Majba', '$2a$10$.s7derW1HlXmpRLyTEJjGOZEV6nZEuYYZqAWYXrIauIHLPm9u5mI6');
INSERT INTO public."user" (user_id, role_id, email, first_name, last_name, password) VALUES (3, 1, 'szathmary@stud.uniza.sk', 'Peter', 'Szathmáry', '$2a$10$rcn.t1DBfl67OcbY/5bqmeRGLuSVkueYmp19I/CgfMz0sQuS1UbM2');

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



