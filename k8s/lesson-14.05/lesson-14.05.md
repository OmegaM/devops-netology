# 14.5 SecurityContext, NetworkPolicies
#### 1
```bash
 k apply -f example-security-context.yml                                                                                                                             ─╯
pod/security-context-demo created

k logs security-context-demo                                                                                                                                        ─╯
uid=1000 gid=3000 groups=3000
```