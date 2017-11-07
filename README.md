## ansible-playbook 一键部署cprs产品

- 需要 Ansible 1.2 或者 更高的版本
- Expects CentOS/RHEL 6.x hosts

These playbooks deploy a very basic implementation of Tomcat Application Server,
version 7. To use them, first edit the "hosts" inventory file to contain the
hostnames of the machines on which you want Tomcat deployed, and edit the 
group_vars/tomcat-servers file to set any Tomcat configuration parameters you need.

执行下面的命令运行这个playbook

	ansible-playbook -i hosts site.yml



This is a very simple playbook and could serve as a starting point for more
complex Tomcat-based projects. 

### Ideas for Improvement

Here are some ideas for ways that these playbooks could be extended:

- Write a playbook to deploy an actual application into the server.
- Deploy Tomcat clustered with a load balancer in front.

### 参考资料:
- http://www.jianshu.com/p/4906516a8d47
- https://www.centos.bz/2017/09/nfs%E8%BD%AF%E4%BB%B6%E6%9C%8D%E5%8A%A1%E5%88%A9%E7%94%A8ansible%E5%AE%9E%E7%8E%B0%E4%B8%80%E9%94%AE%E5%8C%96%E9%83%A8%E7%BD%B2/
- http://blog.csdn.net/qianggezhishen/article/details/53939188
- http://breezey.blog.51cto.com/2400275/1555530/

### 版本更新记录
