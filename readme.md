### 懒人模式

1. （建议）直接下载构建好的 docker tar包导入进去，[nas_ddns.tar](https://github.com/yangxuan0261/nas_ddns/releases)

2. 搜索dockerhub拉取镜像 yangxuan0261/ddns_aliyun

3. [Qnap上创建实例](#Qnap上创建实例)

   ​

------

### 自己构建

1. 从git上拉下docker构建文件

   ```bash
   git clone git@github.com:yangxuan0261/nas_ddns.git
   ```

2. 构建镜像，把 yangxuan0261 换成你自己dockerhub的账号，只用了aliyun.sh ，其他的可以自己去折腾

   ```
   docker build -t yangxuan0261/ddns_aliyun .
   ```

   然后可以导出一个 tar 包，或者 push 到 dockerhub 

   [Qnap上创建实例](#Qnap上创建实例)

   （qnap上使用container station可以忽略）这是Linux下运行的参数，可以在自己的虚拟主机上测试

   ```bash
   docker run -d \
   --restart=always \
   --name ddns_aliyun \
   -e Time="*/5 * * * *" \
   -e ApiId="asd" \
   -e ApiKey="sK60Wasdasdasd" \
   -e Domain="asdasd.com" \
   yangxuan0261/ddns_aliyun
   ```

   - 上面定时 Time 是调度时间。每5分钟一次，具体设置参考 [定时调度](#定时调度) ，其他参数换成你自己参数，域名不要 www 前缀

     ```bash
     root@ubuntu:~/nas_ddns# docker ps -a
     CONTAINER ID        IMAGE                             COMMAND                   CREATED             STATUS              PORTS                     NAMES
     9e1d107b63ad        yangxuan0261/ddns:aliyun          "/bin/sh -c '\"/app..."   12 minutes ago      Up 12 minutes                                 ddns_aliyun
     ```

   - 测试一下，把 域名的记录值 改成其他ip，等待一分钟，自动修改后有邮件通知。



------

### Qnap上创建实例

- 添加几个环境变量即可

  ![这里写图片描述](https://img-blog.csdn.net/20180417183039162)



------

### 定时调度

> https://segmentfault.com/a/1190000002628040

```bash
1、每分钟执行一次            
*  *  *  *  * 

2、每隔一小时执行一次        
00  *  *  *  * 
or
* */1 * * *  (/表示频率)

3、每小时的15和30分各执行一次 
15,45 * * * * （,表示并列）

4、在每天上午 8- 11时中间每小时 15 ，45分各执行一次
15,45 8-11 * * * command （-表示范围）

5、每个星期一的上午8点到11点的第3和第15分钟执行
3,15 8-11 * * 1 command

6、每隔两天的上午8点到11点的第3和第15分钟执行
3,15 8-11 */2 * * command
```



------

### 参考资料

-  https://post.smzdm.com/p/646325/