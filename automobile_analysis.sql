use gauri;
select * from new_automobile;
select * from car_categories;
describe new_automobile;

-- some select function
select count(*) as row_count from new_automobile;
select min(mpg) as min_value from new_automobile;
select max(displacement) as max_value from new_automobile;
select AVG(horsepower) as avg_value from new_automobile;
select SUM(weight) as sum_value from new_automobile;
select min(acceleration) as min_value, max(acceleration) as max_value from new_automobile;
select * from new_automobile where cname like 'Chevrolet%';
select * from new_automobile where model_year in (70, 75, 80);
select * from new_automobile where category <> 'Sedan';
select * from new_automobile where weight between 2000 and 2500;



-- changing column name
alter table new_automobile
rename column `name` to cname;

alter table car_categories
rename column `name` to cname;

-- adding an id column
alter table car_categories 
add id int auto_increment primary key;

-- count of cars in each categories
select category, count(*) as count
from car_categories
GROUP BY category
order by count desc;

-- 10 frequent car names 
select cname , count(*) as count
from new_automobile
group by cname
order by count DESC
limit 10;

-- average mpg of cylinders
select cylinders, avg(mpg) as average_mpg
from new_automobile
group by cylinders;

-- cars with highest and lowest horsepower
select cname, horsepower
from new_automobile
where horsepower = (select max(horsepower) from new_automobile)
or horsepower = (select min(horsepower) from new_automobile);

-- cars with highest and lowest mpg for each car origin
select na.origin, na.cname, na.mpg
from new_automobile na
join(
select origin, max(mpg) as max_mpg, min(mpg) as min_mpg
from new_automobile
group by origin)
sub on na.origin = sub.origin and (na.mpg = sub.max_mpg or na.mpg = sub.min_mpg);
 
-- joining table without common colums
select na.* , cc.category, cc.id
from new_automobile na
join car_categories cc using(cname);


DELIMITER //

create procedure GetAverageHorsepowerByCategory(in p_category varchar(255))
begin
    select avg(horsepower) as avg_horsepower
    from new_automobile  
        where category = p_category;
end //
DELIMITER ;
 
 call GetAverageHorsepowerByCategory('audi');

create view vw_automobile_summary as 
select cname, mpg, horsepower, weight, acceleration,
       (mpg * 1.60934) as kpl,
       (horsepower / weight) as power_to_weight_ratio
from new_automobile;

select * from vw_automobile_summary;




