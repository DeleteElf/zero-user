--系统服务对象
insert into t_service_object (f_name,f_short_name,f_admin_account)
values('研发服务实体','研发测试','admin');

--用户表
insert into t_user_info (F_ID, F_ACCOUNT,F_NAME, F_PASSWORD, F_USER_NAME, F_SEX, F_EMAIL, F_ADDRESS, F_PHONE, F_TELEPHONE,f_sort)
values (1, 'admin','超管', '7ee9c4f86007ba41bc79bbfab1cd8a68', '超级管理员', '男', null, null, null, null, -1);


--部门信息表
insert into t_department_info (F_CODE,F_NAME,F_PARENT_ID,F_SERVICE_ID)
values (null, '测试公司名称', 0,1);

--功能表
insert into t_function_info (F_ID, F_NAME, F_AUTHORIZE_CODE, F_PARENT_ID)
values (1, '功能列表', 'functions', 0);


--角色表
insert into t_role_info (F_ID, F_NAME, F_PARENT_ID)
values (1, '系统管理员', 0);

