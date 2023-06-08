# Zero Cloud

* 第三方库基础环境安装参考[链接](document/LINKS.md)
* [《Zero规范介绍》](http://www.vertx-cloud.cn)

## 1. 基本介绍

### 1.1. 序

&ensp;&ensp;&ensp;&ensp;Zero Cloud是基于Zero
Framework的云端版本，目前Zero框架的Extension部分功能已经可以支撑大部分企业级应用（在ITSM、CMDB、IOT、酒店管理、金融、医疗领域运行了9个生产环境的企业内部系统），在准备发布`1.0.0`
版本之前，我又重新基于云端进行了新的架构设计，准备打造**云原生**平台。

&ensp;&ensp;&ensp;&ensp;早期开发Zero时有一个**侵入式**的微服务云端版本，但那个版本比较初级，当时就是基于`K8S`和`Istio`
最早的版本开发的，底层使用了`etcd`和`gRpc`，如今旧事重提，换一种云端思路来打造新的**云原生**生态，于是有了Zero Cloud。

&ensp;&ensp;&ensp;&ensp;该项目目前没有核心代码，核心代码会收录在`vertx-zero/vertx-istio`
子项目中，当前项目主要提供云端架构的指导规范、概念定义、设计思路、自动化脚本以及云端项目脚手架，并通过自动化或半自动化模式使完整生态落地。

### 1.2. 结构（概念版）

> Zero Cloud的基础系统设计并没有完全按照云原生十二要素进行，由于K8S和Istio已经提供了底层大部分基础设施功能，所以Zero
> Cloud将所有精力集中于**应用层**，根据部署运维的视角，其实客户本身的应用系统是一个**平行四边形**结构。

![](./document/_image/2022-07-20/20220720145836.png)

<hr/>

## 2. 目录说明

### 2.1. vertx-zero-cloud

|目录名|所属|说明|
|---|---|---|
|development|vertx-zero-cloud|研发/开发环境工具目录。|
|document|vertx-zero-cloud|内置文档目录。|
|toolkit|vertx-zero-cloud|脚本工具专用目录。|
|apps|xxx-cloud|全局环境配置模板。|
|environment|xxx-cloud|环境分流格式专用配置目录。|
|platform|xxx-cloud|多语言资源配置分流目录。|

&ensp;&ensp;&ensp;&ensp;对vertx-zero-cloud而言，xxx-cloud系统平台是单独的一个app，而xxx-cloud其本身是一个**
多租户、多语言、多应用**的环境，至于结构图中的**多环境、多区域**和部署应用没有直接关系，大部分是在底层K8S这一级实现分离。

### 2.2. xxx-cloud

&ensp;&ensp;&ensp;&ensp;无须手工创建，直接设置环境变量后运行初始化脚本即可，`xxx-cloud`自带分类配置：

* K8S环境配置：用于描述该平台发布到哪种K8S环境中（五选一）
* 应用语言配置：用于描述该平台使用哪种语言优先（三选一）

|目录名|类型|说明|
|---|---|---|
|database/mysql|目录|（K8S挂载）MySQL数据库文件目录。|
|database/tidb|目录|（K8S挂载）TiDB数据库文件目录。|
|development|目录|和vertx-zero-cloud中的development维持一致，协同开发。|
|deployment|目录|（五选一）对应vertx-zero-cloud中的environment。|
|kzero|目录|（生产运行）对应vertx-zero-cloud中的platform。|
|kidd|目录|（生产运行）和kzero协同处理配置的专用平台。|
|kinect|目录|（开发测试）低代码所见即所得专用平台。|
|zapp.yml|文件|当前平台的全局统一配置。|
|zapp-axis.yml|文件|当前平台核心引擎配置。|
|zapp-modulat.yml|文件|当前平台的Zero模块化配置，标准化专用。|
|zapp-plugin.yml|文件|当前平台的功能插件配置，集成和IT驱动专用。|
|zapp-down.yml|文件|当前平台下的app-children专用配置（子系统、子模块专用）。|
|zapp-up.yml|文件|和vertx-zero-cloud连接执行协同处理的专用配置。|
|k-app.sh|文件|初始化环境融合脚本，融合出厂设置、平台特有专用。|
|k-init.sh|文件|初始化环境专用脚本。|
|.env.development|文件|开发用环境变量。|
|.env.production|文件|生产用环境变量。|

### 2.3. 设计理念

* `xxx-cloud`必须实现自动化运维、管理、更新以及不下线。
* `vertx-zero-cloud`属于`xxx-cloud`的中枢神经系统，它提供了整个平台环境的专有规范，更新时自动分发**出厂设置**
  给每一个`xxx-cloud`。
* `xxx-cloud`本身的Github库中记录了所有版本变更，配置层用于协调生产、开发、测试环境的无缝切换。
* 二者协同实现**双平台**架构，上游平台和下游平台各司其职，上游平台负责开发、运维、监控、管理以及命令和事件的分发，下游平台负责应用变更、需求适配。

<hr/>

## 3. 系统规范

### 3.1. K8S环境类型

&ensp;&ensp;&ensp;&ensp;Zero Cloud中定义了K8S的运行环境，位于目录`environment`中，而每一个`xxx-cloud`
只能选择一种，之中所包含的脚本和相关部署工具都相互独立、相互隔离，其核心环境如下（只有两个可以上生产）：

| 目录名     | 类型     | 说明              |
|---------|--------|-----------------|
| `kmini` | 开发     | 本地Minikube开发环境。 |
| `k8s`   | 开发/测试  |远程Minikube开发测试环境（单节点）。|
| `kmt`| 压测| 预发布压力测试专用环境（单节点 / 集群）。|
| `ki`    | 生产     |远程标准环境（单节点 / 集群）。|
| `kiha`  | 生产/高可用 |远程HA环境（集群）。|

### 3.2. 组件环境

&ensp;&ensp;&ensp;&ensp;K8S的每个目录会包含各种功能型组件的核心目录，其支持功能是横向的，所有`xxx-cloud`
都可以选择启用或禁用。`etcd`是K8S自带，所以此处不考虑etcd的启动和部署脚本，以下环境是目前可以直接和zero执行集成的核心环境，大部分内容zero-framework中已提供了集成客户端以及相关代码。

| 项 | 说明 |
|:---|---|
|`/cloud/*`| Zero Cloud部署脚本/配置。|
|`/elk/*`| ELK日志平台部署脚本/配置。|
|`/es/*`| ElasticSearch部署脚本/配置。 |
|`/hcp/*`| HCP Vault部署脚本/配置。|
|`/istio/*` | Istio启动脚本。|
|`/kafka/*`| Kafka部署脚本/配置。|
|`kiali/*`| Kiali部署脚本/配置。|
|`/mysql/*` | MySQL部署脚本/配置。|
|`/neo4j/*` | Neo4J部署脚本/配置。|
|`/pts/*`|Prometheus部署脚本/配置。|
|`/redis/*` | Redis部署脚本/配置。|
|`/tidb/*`| TiDB部署脚本/配置。|
|`/zipkin/*`| Zipkin部署脚本/配置。|

<hr/>

## 4. 应用规范

### 4.1. 语言分类

| 项 | 说明 |
|---|---|
| cn | 中文 |
| en | 英文（保留） |
| jp | 日文（保留） |

### 4.2. 环境分类

| 项 | 类型  | 说明 |
|---|---|---|
| `kzero`  | 出厂  | 平台基础默认环境。                 |
| `kidd`   | 运行 | 不下线的云端运行环境，kzero冗余镜像。     |
| `kinect` | 测试/预发布 | 从`kzero -> kidd`的预发布验证环境。 |

1. `kzero`为静态环境，环境中不包含相关配置，云端部署和发布时，会直接以此目录中的所有配置信息为基版本。
2. `kidd/kinect`为运行环境，其中会包含整套配置信息，基于平台目录相关配置都存储于该目录中。

### 4.3. 配置文件

|项|说明|
|---|---|
|zcloud.yml|平台连接配置目录。|
|zcloud-plugin.yml|插件启用配置，可配置`environment`中所需部署脚本。|
|zcloud-axis.yml|开发专用配置，配置低代码平台。|
|zcloud-modulat.yml|模块化专用配置文件。|

### 4.4. 应用配置目录

|项|说明|
|---|---|
|asset/admin|「OOB」平台共享管理目录。|
|asset/modulat|「OOB」模块化专用目录。|
|asset/tenant|「OOB」租户专用目录。|
|asset/istio|「OOB」K8S连接配置专用目录。|
|atom/workflow|「OOB」工作流引擎专用配置目录。|
|atom/emf|「OOB」模型专用配置目录（基于EMF）。|
|atom/authorize|「OOB」权限管理配置专用目录。|
|atom/integration|「OOB」集成服务配置专用目录。|
|atom/graphic|「OOB」拓扑图配置专用目录。|
|atom/tpl|「OOB」模板系统配置专用目录。|
|action/job|「OOB」操作执行任务定义。|
|action/api|「OOB」操作执行接口定义。|
|action/lexeme|「OOB」操作执行语义转换定义。|
|action/rule|「OOB」操作执行规则定义。|
|above/page|「OOB」呈现配置页面。|
|above/form|「OOB」呈现配置表单。|
|above/list|「OOB」呈现配置列表。|
|above/event|「OOB」呈现行为配置目录。|

<hr/>

## 5. 整体拓扑

> 以最新版为准，该图是老版本，后续定型后重新更新。

![](./document/_image/2022-07-20/20220720164554.png)

<hr/>

## 6. 应用初始化

### 6.1. 环境变量

&ensp;&ensp;&ensp;&ensp;环境变量命名规范如下：

* `ZK`打头，全称Zero Kernel，容器相关的环境变量。
* `ZA`打头，全称Zero Aeon，**永世系统**核心驱动层组件专用。
* `ZC`打头，全称Zero Component，每个应用专有的环境变量。

&ensp;&ensp;&ensp;&ensp;环境变量如：

| 类型 | 名称 | 说明 |
|---|---|---|
| Zero Kernel | `ZK_NS`| 应用APP的名空间。|
| Zero Kernel | `ZK_CONFIG`| 应用APP核心配置文件路径。|
| Zero Aeon | `ZA_ENV`| 环境五选一，默认`kmini`。|
| Zero Aeon | `ZA_LANG`| 语言三选一，默认cn。|
| TiDB| `ZC_TIDB` | TiDB名称。|
| TiDB| `ZC_TIDB_STORE` | TiDB挂载的存储数据文件的路径（物理路径）。 |

### 6.2. 初始化步骤

1. 创建一个Maven的空项目，并链接到您的Git私库中。
2. 从`vertx-zero/vertx-istio/scaffold`中下载核心文件到项目根目录。

    ```shell
    .env.development            # 开发环境文件
    k-app.sh                    # 初始化环境融合脚本
    k-init.sh                   # 初始化环境脚本
    ```
3. 修改`.env.development`环境变量。
4. 运行`k-app.sh`自动执行当前项目初始化。

### 6.3. 基本环境要求

|项|说明|
|---|---|
|JDK| 17+（推荐ZuLu）|
|Node| 18.x+ |
|envsubst| 该命令必须可用，网上参考安装教程。|
|minikube|（开发）K8S迷你环境、单节点。|
|docker|（开发）容器环境。|

<hr/>

## 7. 运行说明

### 7.1. 脚本命名规范

* `minikube-`：基本环境启动脚本（包括dashboard）。
* `istio-`：Istio环境安装脚本。
* `zo-`（Zero Deployment to K8S）脚本：发布组件到K8S的专用脚本。
* `zp-`（Zero Purge from K8S）脚本：从K8S清除当前组件专用脚本。
* `zq-`（Zero Query）脚本：查询组件状态专用脚本。
* 如果该脚本需开放或启动某个端口号，则以端口号名称为文件前缀，如：
    * `1201-istioctl-kiali.sh`
    * `1231-minicube-dashboard.sh`

### 7.2. 默认端口

* 1231：Dashboard主端口号。
* 1201 ~ 1299：辅助工具主端口号。
* Random：以组件标准为主，如TiDB是4000，程序消费专用端口号。

|端口|类型|说明|
|---|---|---|
|1231|Minikube|Minikube Dashboard专用端口号，查看K8S集群专用。|
|1201|Kaili|Kaili监控平台专用端口号。|
|1202|TiDB|TiDB Grafana专用端口号。|
|1203|TiDB|TiDB Prometheus专用端口号。|
|4000|TiDB|TiDB数据库专用端口号。|