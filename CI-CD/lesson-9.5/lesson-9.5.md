# 09.05 Teamcity

![container](../../imgs/ts_container.png)
![agent start](../../imgs/tc_agent_start.png)
![server starting](../../imgs/tc_start.png)
![agent authorized](../../imgs/tc_agent_connect.png)
![nexus](../../imgs/nexus_playbook_finish.png)

#### 1-2.
![detecting](../../imgs/tc_auto_detecting_build_steps.png)

#### 3.
![first_build_start](../../imgs/first_build_start.png)
#### 4.
![conditions](../../imgs/tc_build_conditions.png)
#### 5.
![settings](../../imgs/tc_maven_settings.png)
#### 6.
https://github.com/OmegaM/example-teamcity/commit/cf9eda4450ae1d78753b2360c0faed543d6a1bb5
#### 7.
![tc_branch_conbdition](../../imgs/tc_branch_condition.png)
![nexus_publish](../../imgs/tc_artifact_deploy.png)
#### 8.
![ssh](../../imgs/tc_ssh_vcs_root.png)
![configuration migration](../../imgs/tc_project_config_migration.png)
https://github.com/OmegaM/example-teamcity/commit/ad8afa5ff18120ff521348dad46a836d72a2a3e2
#### 9.
```bash
$ git switch -c feature/add_reply ; git push -u origin feature/add_reply
Switched to a new branch 'feature/add_reply'
Total 0 (delta 0), reused 0 (delta 0)
remote:
remote: Create a pull request for 'feature/add_reply' on GitHub by visiting:
remote:      https://github.com/OmegaM/example-teamcity/pull/new/feature/add_reply
remote:
To github.com:OmegaM/example-teamcity.git
 * [new branch]      feature/add_reply -> feature/add_reply
Branch 'feature/add_reply' set up to track remote branch 'feature/add_reply' from 'origin'.
```
#### 10.
```java
...
 public String sayTestReplic() {
    return "Test hunter replic here!";
}
```
#### 11.
```java
...
@Test
 public void testHunterReplic(){
    assertThat(welcomer.sayTestReplic(), containsString("hunter"));
}
```
#### 12.
```bash
$ git commit -m "Added test public method + Unit test"
[feature/add_reply b66587e] Added test public method + Unit test
 2 files changed, 8 insertions(+), 1 deletion(-)
$ git push
Enumerating objects: 20, done.
Counting objects: 100% (20/20), done.
Delta compression using up to 4 threads
Compressing objects: 100% (6/6), done.
Writing objects: 100% (11/11), 835 bytes | 139.00 KiB/s, done.
Total 11 (delta 3), reused 0 (delta 0)
remote: Resolving deltas: 100% (3/3), completed with 3 local objects.
To github.com:OmegaM/example-teamcity.git
   ad8afa5..b66587e  feature/add_reply -> feature/add_reply
```
#### 13.
![custom branch build](../../imgs/custom_branch_build.png)
#### 14.
```bash
$ git checkout master ; git merge feature/add_reply; git push
Switched to branch 'master'
Your branch is up to date with 'origin/master'.
Updating ad8afa5..b66587e
Fast-forward
 src/main/java/plaindoll/Welcomer.java     | 3 +++
 src/test/java/plaindoll/WelcomerTest.java | 6 +++++-
 2 files changed, 8 insertions(+), 1 deletion(-)
Total 0 (delta 0), reused 0 (delta 0)
To github.com:OmegaM/example-teamcity.git
   ad8afa5..b66587e  master -> master
```
#### 15.
![artifacts](../../imgs/tc_master_artifacts.png)
#### 16.
![artifact configuration](../../imgs/tc_artifact_configuration.png)
#### 17.
![creating new build configuration](../../tc_new_test_config.png)
#### 18.
![new project configs](../../imgs/tc_sync_build_configs_to_new_project.png)
