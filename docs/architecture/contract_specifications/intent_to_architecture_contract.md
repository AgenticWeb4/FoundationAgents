# 契约驱动设计 (Contract-Driven Design)

## 🎯 核心设计理念

### **什么是契约驱动设计？**

契约驱动设计是一种**以业务价值为核心**的软件开发方法，通过定义清晰的业务契约来指导系统的设计和实现。它不是技术驱动的架构设计，而是**业务驱动的价值设计**。

#### **核心价值主张**
```
业务价值 → 业务契约 → 技术契约 → 代码实现
├── 业务价值: 解决什么业务问题，创造什么价值
├── 业务契约: 业务规则、约束和协作关系
├── 技术契约: 技术接口、行为和状态管理
└── 代码实现: 具体的代码实现
```

### **为什么选择契约驱动设计？**

#### **1. 业务价值导向**
- **解决真实问题**: 不是为技术而技术，而是为业务而技术
- **价值可衡量**: 每个契约都有明确的业务价值
- **投资回报**: 技术投入直接对应业务产出

#### **2. 团队协作增强**
- **业务语言**: 用业务术语定义契约，业务团队能理解
- **技术语言**: 用技术术语实现契约，技术团队能执行
- **共同语言**: 形成业务和技术都能理解的统一语言

#### **3. 系统质量提升**
- **一致性保证**: 契约确保业务逻辑的一致性
- **可维护性**: 清晰的契约让系统更易维护
- **可扩展性**: 契约为系统扩展提供清晰边界

## 🏗️ 契约设计核心原理

### **1. 业务契约原理**

#### **业务契约的本质**
业务契约不是技术接口，而是**业务规则和约束的明确表达**。

```
业务契约 = 业务规则 + 业务约束 + 业务协作
├── 业务规则: 业务必须遵循的规则和逻辑
├── 业务约束: 业务必须满足的条件和限制
└── 业务协作: 不同业务实体如何协作
```

#### **业务契约设计原则**
- **价值导向**: 每个契约都要有明确的业务价值
- **规则明确**: 业务规则要清晰、可验证
- **约束合理**: 业务约束要合理、可执行
- **协作清晰**: 业务协作要明确、可追踪

### **2. 技术契约原理**

#### **技术契约的本质**
技术契约是**业务契约在技术层面的实现**，确保技术实现符合业务要求。

```
技术契约 = 接口定义 + 行为约定 + 状态管理
├── 接口定义: 组件如何交互
├── 行为约定: 组件的行为和职责
└── 状态管理: 组件的状态变化
```

#### **技术契约设计原则**
- **业务映射**: 技术契约要准确映射业务契约
- **职责清晰**: 每个组件的职责要明确
- **依赖明确**: 组件间的依赖关系要清晰
- **状态可控**: 状态变化要可控、可预测

### **3. 契约映射原理**

#### **从业务到技术的映射**
```
用户故事 → 业务契约 → 技术契约 → 代码实现
├── 用户故事: "作为[角色]，我想要[功能]，以便[价值]"
├── 业务契约: 业务规则、约束、协作
├── 技术契约: 接口、行为、状态
└── 代码实现: 具体的代码实现
```

#### **映射验证原则**
- **完整性**: 业务契约要完整映射到技术契约
- **一致性**: 技术实现要与业务契约保持一致
- **可追溯**: 从代码到业务契约要可追溯
- **可验证**: 契约的实现要可验证、可测试


## 🏛️ 架构映射指导

### **需求到架构要素映射**
基于Clean Architecture + BLoC模式，建立清晰的映射关系：

#### **用户故事映射模式**
```
"As a [role], I want [feature] so that [benefit]"
↓
role → User Entity/Repository
feature → Domain Use Case + Presentation Feature  
benefit → Business Value + Success Criteria
```

#### **业务场景映射模式**
```
"Given [context], When [action], Then [outcome]"
↓
context → Domain Entity + State
action → Use Case + BLoC Event
outcome → BLoC State + UI Update
```

#### **领域事件映射模式**
```
"Event triggers State change"
↓
event → BLoC Event + Use Case Input
processing → Use Case + Repository
state → BLoC State + UI State
```

### **架构层次关系**
```
presentation (UI层)
├── 依赖: domain层
├── 组件: pages, widgets, bloc
└── 职责: UI渲染, 用户交互, 状态显示

domain (领域层)  
├── 依赖: core层
├── 组件: entities, usecases, repositories
└── 职责: 业务逻辑, 领域规则, 用例编排

data (数据层)
├── 依赖: domain层, core层
├── 组件: models, datasources, repository_impl
└── 职责: 数据持久化, 外部API, 数据转换

core (核心层)
├── 依赖: 无
├── 组件: constants, theme, utils, widgets, di
└── 职责: 共享工具, 依赖注入, 通用组件
```

## 🎯 三种契约方案的架构映射策略

### **方案选择决策矩阵**

| 考虑因素 | 方案1: 分层契约 | 方案2: 事件驱动契约 | 方案3: 聚合实体契约 |
|---------|----------------|-------------------|-------------------|
| **架构复杂度** | 低-中 | 中 | 中-高 |
| **团队经验** | 初级-中级 | 中级 | 中级-高级 |
| **业务复杂度** | 简单-中等 | 中等 | 复杂 |
| **状态管理** | 简单 | 复杂 | 中等 |
| **维护成本** | 低 | 中 | 中-高 |
| **扩展性** | 中等 | 高 | 高 |

### **适用场景分析**

#### **方案1: 分层契约映射 (推荐起点)**
**最佳适用场景**:
- 🎯 **项目初期**: 建立基础架构规范
- 🎯 **团队学习**: 理解Clean Architecture原则
- 🎯 **简单功能**: 基础的CRUD操作
- 🎯 **快速开发**: 需要快速交付的项目

**架构映射特点**:
```
需求 → 架构层 → 具体组件
↓
用户管理 → presentation层 → UserBloc + UserPage
用户管理 → domain层 → UserEntity + UserRepository
用户管理 → data层 → UserModel + UserRepositoryImpl
```

#### **方案2: 事件驱动契约 (状态管理复杂时)**
**最佳适用场景**:
- 🎯 **复杂状态**: 多状态、多事件交互
- 🎯 **工作流**: 需要状态机管理的业务
- 🎯 **实时更新**: 频繁的状态变化
- 🎯 **调试需求**: 需要清晰的事件追踪

**架构映射特点**:
```
需求 → 事件流 → 状态转换 → 组件更新
↓
用户操作 → LoadUserEvent → UserLoading → UserPage显示加载
用户操作 → UpdateUserEvent → UserUpdating → UserPage显示更新
用户操作 → SaveUserEvent → UserSaving → UserPage显示保存
```

#### **方案3: 聚合实体契约 (业务逻辑复杂时)**
**最佳适用场景**:
- 🎯 **复杂业务**: 多实体协作的业务场景
- 🎯 **领域建模**: 需要清晰的业务边界
- 🎯 **规则复杂**: 复杂的业务规则和约束
- 🎯 **团队成熟**: 有DDD经验的团队

**架构映射特点**:
```
需求 → 业务聚合 → 实体协作 → 组件实现
↓
订单管理 → Order聚合 → Order + OrderItem + Payment
订单管理 → 业务规则 → 库存检查 + 价格计算 + 状态验证
订单管理 → 组件实现 → OrderBloc + OrderPage + OrderWidget
```

### **混合策略推荐**

#### **渐进式实施策略**
```
阶段1: 基础架构 (方案1)
├── 建立分层契约基础
├── 团队熟悉架构原则
└── 完成核心功能开发

阶段2: 状态优化 (方案1 + 方案2)
├── 保持分层契约结构
├── 引入事件驱动契约
└── 优化复杂状态管理

阶段3: 业务深化 (方案1 + 方案2 + 方案3)
├── 保持架构一致性
├── 引入聚合实体契约
└── 优化复杂业务逻辑
```

#### **功能特性选择策略**
```
简单CRUD功能 → 方案1 (分层契约)
├── 用户管理、配置管理
├── 基础的增删改查
└── 简单的状态管理

复杂状态管理 → 方案2 (事件驱动契约)
├── 表单验证、多步骤流程
├── 实时数据更新
└── 复杂的状态转换

复杂业务逻辑 → 方案3 (聚合实体契约)
├── 订单处理、工作流
├── 多实体协作
└── 复杂的业务规则
```

### **实施建议**

#### **团队能力评估**
- **初级团队**: 从方案1开始，逐步学习架构原则
- **中级团队**: 可以同时使用方案1和方案2
- **高级团队**: 可以灵活组合三种方案

#### **项目复杂度评估**
- **简单项目**: 方案1足够满足需求
- **中等项目**: 方案1 + 方案2的组合
- **复杂项目**: 三种方案的组合使用

#### **维护成本考虑**
- **短期项目**: 可以优先考虑开发效率
- **长期项目**: 需要平衡开发效率和维护成本
- **团队稳定性**: 稳定的团队可以承担更高的维护成本

这样的架构映射指导既考虑了三种方案的适用性，又提供了具体的实施策略，帮助团队根据实际情况选择最合适的方案组合。

## 🎯 基于当前架构的契约设计方案

基于您的Clean Architecture + BLoC架构，我推荐以下三个契约设计方案：

### **方案1: 分层契约映射方案 (最推荐)**
**核心思想**: 严格按照架构层次定义契约，确保依赖关系清晰

**契约结构**:
```json
{
  "feature": "用户信息管理",
  "layers": {
    "presentation": {
      "contracts": {
        "UserProfileBloc": {
          "events": ["LoadProfile", "UpdateProfile", "SaveProfile"],
          "states": ["ProfileInitial", "ProfileLoading", "ProfileLoaded", "ProfileError"],
          "dependencies": ["GetUserProfile", "UpdateUserProfile"]
        },
        "UserProfilePage": {
          "widgets": ["ProfileForm", "ProfileDisplay"],
          "dependencies": ["UserProfileBloc"]
        }
      }
    },
    "domain": {
      "contracts": {
        "UserProfile": {
          "type": "aggregate_root",
          "properties": ["id", "name", "email", "phone", "updatedAt"],
          "businessRules": ["email必须有效", "name不能为空"],
          "operations": ["updateProfile", "validateProfile"]
        },
        "GetUserProfile": {
          "type": "use_case",
          "input": "GetUserProfileParams",
          "output": "Either<AppError, UserProfile>",
          "dependencies": ["UserProfileRepository"]
        }
      }
    },
    "data": {
      "contracts": {
        "UserProfileRepository": {
          "type": "interface",
          "methods": ["getProfile", "updateProfile", "deleteProfile"],
          "contracts": ["数据一致性", "事务支持"]
        },
        "UserProfileModel": {
          "type": "data_model",
          "properties": ["id", "name", "email", "phone", "updatedAt"],
          "mapping": "UserProfile实体映射"
        }
      }
    }
  }
}
```

**优势**: 
- 完全符合Clean Architecture原则
- 依赖关系清晰明确
- 易于维护和扩展
- 支持分层测试

### **方案2: 事件驱动契约方案 (最匹配)**
**核心思想**: 以BLoC事件为中心，定义完整的事件流和状态转换

**契约结构**:
```json
{
  "feature": "用户信息管理",
  "eventFlow": {
    "LoadUserProfile": {
      "trigger": "页面初始化",
      "flow": {
        "presentation": {
          "event": "LoadUserProfile",
          "state": "ProfileLoading"
        },
        "domain": {
          "useCase": "GetUserProfile",
          "input": "GetUserProfileParams"
        },
        "data": {
          "repository": "UserProfileRepository.getProfile",
          "dataSource": "UserProfileDataSource"
        },
        "response": {
          "success": {
            "state": "ProfileLoaded",
            "data": "UserProfile实体"
          },
          "error": {
            "state": "ProfileError",
            "message": "错误信息"
          }
        }
      }
    },
    "UpdateUserProfile": {
      "trigger": "用户点击保存",
      "flow": {
        "presentation": {
          "event": "UpdateUserProfile",
          "state": "ProfileUpdating"
        },
        "domain": {
          "useCase": "UpdateUserProfile",
          "validation": "ProfileValidator"
        },
        "data": {
          "repository": "UserProfileRepository.updateProfile",
          "persistence": "本地存储 + API同步"
        }
      }
    }
  }
}
```

**优势**:
- 完美匹配BLoC模式
- 事件流清晰可见
- 状态转换明确
- 易于调试和测试

### **🏆 最推荐方案: 聚合实体契约方案 (语义化命名版)**

**核心思想**: 结合分层契约的清晰架构、纯展示层的事件流管理，以及CQRS的查询命令分离原则，形成完整的业务聚合契约。采用语义化命名，让大模型和开发者都能快速理解业务逻辑。

**架构优势**: 分层架构 + 纯展示层事件流 + 业务聚合 + CQRS分离 + 语义化命名
```json
{
  "feature": "用户信息管理",
  "architecture": {
    "presentation": {
      "uiContracts": {
        "UserProfileBloc": {
          "userActions": ["LoadProfile", "UpdateProfile", "SaveProfile", "LoadAggregatedProfile"],
          "uiStates": ["ProfileInitial", "ProfileLoading", "ProfileLoaded", "ProfileError", "AggregatedProfileLoaded"]
        }
      },
      "userInteractionFlow": {
        "LoadProfile": {
          "userTrigger": "页面初始化",
          "action": "LoadProfile",
          "stateSequence": ["ProfileLoading", "ProfileLoaded"],
          "businessLogic": ["GetUserProfile"],
          "flowSteps": [
            {"action": "LoadProfile", "nextState": "ProfileLoading"},
            {"state": "ProfileLoaded", "displayData": "UserProfile"}
          ]
        },
        "LoadAggregatedProfile": {
          "userTrigger": "需要完整用户信息",
          "action": "LoadAggregatedProfile",
          "stateSequence": ["ProfileLoading", "AggregatedProfileLoaded"],
          "businessLogic": ["GetUserAggregatedProfile"],
          "flowSteps": [
            {"action": "LoadAggregatedProfile", "nextState": "ProfileLoading"},
            {"state": "AggregatedProfileLoaded", "displayData": "UserProfileAggregatedView"}
          ]
        },
        "UpdateProfile": {
          "userTrigger": "用户更新信息",
          "action": "UpdateProfile",
          "stateSequence": ["ProfileUpdating", "ProfileLoaded"],
          "businessLogic": ["UpdateUserProfile"],
          "flowSteps": [
            {"action": "UpdateProfile", "nextState": "ProfileUpdating"},
            {"state": "ProfileLoaded", "displayData": "UserProfile"}
          ]
        }
      }
    },
    "domain": {
      "businessContracts": {
        "UserProfile": {
          "contractType": "aggregate_root",
          "businessProperties": ["id", "name", "email", "phone"],
          "businessRules": ["email必须有效", "name不能为空"]
        },
        "GetUserProfile": {
          "contractType": "query_operation",
          "inputData": "GetUserProfileParams",
          "resultData": "Either<AppError, UserProfile>",
          "requiredServices": ["UserProfileRepository"],
          "businessPurpose": "获取用户档案信息"
        },
        "UpdateUserProfile": {
          "contractType": "command_operation",
          "inputData": "UpdateUserProfileParams",
          "resultData": "Either<AppError, UserProfile>",
          "requiredServices": ["UserProfileRepository"],
          "businessPurpose": "更新用户档案信息",
          "businessRules": ["权限验证", "数据验证", "业务规则检查"]
        },
        "GetUserAggregatedProfile": {
          "contractType": "composite_query_operation",
          "inputData": "UserProfileViewParams",
          "resultData": "Either<AppError, UserProfileAggregatedView>",
          "requiredServices": ["GetUserProfile", "GetUserPreferences", "GetUserActivity"],
          "serviceComposition": {
            "userProfile": "GetUserProfile",
            "userPreferences": "GetUserPreferences", 
            "userActivity": "GetUserActivity"
          },
          "businessPurpose": "获取用户完整信息视图",
          "businessRules": ["用户必须已登录", "数据权限验证", "聚合数据一致性检查"]
        }
      }
    },
    "data": {
      "serviceContracts": {
        "UserProfileRepository": {
          "contractType": "data_service_interface",
          "serviceMethods": ["getProfile", "updateProfile", "deleteProfile"]
        },
        "UserPreferencesRepository": {
          "contractType": "data_service_interface",
          "serviceMethods": ["getPreferences", "updatePreferences"]
        },
        "UserActivityRepository": {
          "contractType": "data_service_interface",
          "serviceMethods": ["getRecentActivity", "logActivity"]
        }
      }
    }
  },
  "businessAggregate": {
    "aggregateRoot": "UserProfile",
    "aggregateEntities": ["UserProfile", "UserPreferences", "UserActivity"],
    "aggregateRules": ["email必须有效", "name不能为空", "用户必须已登录"]
  }
}
```

## 🎯 语义化命名优势

### **1. 大模型友好性**
- **语义清晰**: `userInteractionFlow` 比 `eventFlow` 更容易理解
- **业务导向**: `businessLogic` 比 `dependencies` 更体现业务价值
- **流程明确**: `flowSteps` 比 `flow` 更清楚地表达步骤

### **2. 开发者友好性**
- **命名直观**: `userActions` 比 `events` 更容易理解
- **职责明确**: `businessPurpose` 比 `responsibility` 更体现业务目标
- **结构清晰**: `stateSequence` 比 `states` 更清楚地表达状态序列

### **3. 业务价值体现**
- **价值导向**: 每个命名都体现业务价值，不是技术实现
- **协作清晰**: `serviceComposition` 比 `composition` 更清楚地表达服务组合
- **边界明确**: `businessAggregate` 比 `aggregate` 更清楚地表达业务聚合

## 🔍 CQRS优化分析

### **查询与命令分离的优势**

#### **1. 职责清晰**
- **Command Use Cases**: 负责修改聚合状态，包含业务规则验证
- **Query Use Cases**: 负责数据查询，不修改状态
- **Composite Query Use Cases**: 组合多个原子查询用例

#### **2. 查询基于融合多个原子Use Case**
- **正确性**: 查询应该基于融合多个原子use case，而不是直接组合仓储类
- **优势**: 
  - 保持业务逻辑的一致性
  - 复用已有的查询用例
  - 便于测试和维护
  - 符合单一职责原则

#### **3. 架构优化**
- **移除queryAggregator**: 避免重复定义聚合逻辑
- **统一依赖管理**: 所有查询都通过use case进行
- **清晰的依赖关系**: 复合查询依赖原子查询，原子查询依赖仓储

## 🏗️ 架构分层与事件流整改建议

### **问题分析**

#### **1. 事件流架构错误**
- **错误理解**: `eventFlow`的`data`层不应该包含仓储调用细节
- **正确理解**: `eventFlow`应该专注于事件驱动的流程表达，不涉及具体的数据操作

#### **2. 分层职责混乱**
- **presentation层**: 应该定义事件和状态，管理用户交互
- **domain层**: 应该定义业务用例，不暴露数据层细节
- **data层**: 应该在仓储实现中处理，不在契约中暴露

#### **3. 事件流本质**
- **事件流**: 是展示层的状态管理流程，不是跨层的数据操作流程
- **职责**: 描述用户操作如何触发状态变化，而不是如何获取数据

### **三个整改版本建议**

#### **版本A: 纯展示层事件流 (推荐指数: ⭐⭐⭐⭐⭐)**
**核心思想**: 事件流完全在展示层内，专注于UI状态管理

```json
{
  "presentation": {
    "contracts": {
      "UserProfileBloc": {
        "events": ["LoadProfile", "UpdateProfile", "SaveProfile", "LoadAggregatedProfile"],
        "states": ["ProfileInitial", "ProfileLoading", "ProfileLoaded", "ProfileError", "AggregatedProfileLoaded"],
        "dependencies": ["GetUserProfile", "UpdateUserProfile", "GetUserAggregatedProfile"]
      }
    },
    "eventFlow": {
      "LoadProfile": {
        "trigger": "页面初始化",
        "flow": [
          {"event": "LoadProfile", "state": "ProfileLoading"},
          {"state": "ProfileLoaded", "data": "UserProfile"}
        ]
      },
      "LoadAggregatedProfile": {
        "trigger": "需要完整用户信息",
        "flow": [
          {"event": "LoadAggregatedProfile", "state": "ProfileLoading"},
          {"state": "AggregatedProfileLoaded", "data": "UserProfileAggregatedView"}
        ]
      }
    }
  }
}
```

**优势**: 
- 职责清晰，事件流完全在展示层
- 不暴露领域层和数据层细节
- 符合BLoC模式的设计原则

#### **版本B: 分层契约独立 (推荐指数: ⭐⭐⭐⭐)**
**核心思想**: 每层独立定义契约，事件流作为展示层的独立部分

```json
{
  "layers": {
    "presentation": {
      "contracts": {
        "UserProfileBloc": {
          "events": ["LoadProfile", "UpdateProfile", "SaveProfile", "LoadAggregatedProfile"],
          "states": ["ProfileInitial", "ProfileLoading", "ProfileLoaded", "ProfileError", "AggregatedProfileLoaded"],
          "dependencies": ["GetUserProfile", "UpdateUserProfile", "GetUserAggregatedProfile"]
        }
      },
      "eventFlow": {
        "LoadProfile": {
          "trigger": "页面初始化",
          "flow": [
            {"event": "LoadProfile", "state": "ProfileLoading"},
            {"state": "ProfileLoaded"}
          ]
        }
      }
    },
    "domain": {
      "contracts": {
        "GetUserProfile": {
          "type": "query_use_case",
          "input": "GetUserProfileParams",
          "output": "Either<AppError, UserProfile>",
          "dependencies": ["UserProfileRepository"]
        }
      }
    }
  }
}
```

**优势**: 
- 分层清晰，每层职责独立
- 事件流作为展示层的独立组件
- 便于维护和扩展

#### **版本C: 事件驱动架构 (推荐指数: ⭐⭐⭐)**
**核心思想**: 事件流作为整个系统的驱动机制，但保持分层清晰

```json
{
  "eventFlow": {
    "LoadUserProfile": {
      "trigger": "页面初始化",
      "presentation": {
        "event": "LoadProfile",
        "state": "ProfileLoading"
      },
      "domain": {
        "useCase": "GetUserProfile"
      }
    }
  },
  "layers": {
    "presentation": {
      "contracts": {
        "UserProfileBloc": {
          "events": ["LoadProfile", "UpdateProfile", "SaveProfile", "LoadAggregatedProfile"],
          "states": ["ProfileInitial", "ProfileLoading", "ProfileLoaded", "ProfileError", "AggregatedProfileLoaded"],
          "dependencies": ["GetUserProfile", "UpdateUserProfile", "GetUserAggregatedProfile"]
        }
      }
    }
  }
}
```

**优势**: 
- 事件驱动架构清晰
- 保持分层职责
- 适合复杂的事件流管理

### **🏆 推荐选择: 版本A (纯展示层事件流)**

**选择理由**:
1. **职责清晰**: 事件流完全在展示层，不跨越架构边界
2. **符合BLoC**: 与Flutter BLoC模式的设计原则一致
3. **易于维护**: 展示层的变化不影响领域层和数据层
4. **架构清晰**: 每层职责明确，依赖关系清晰

**核心原则**:
- **事件流**: 只关注UI状态变化，不涉及业务逻辑
- **分层契约**: 每层独立定义自己的契约
- **依赖关系**: 展示层依赖领域层，领域层依赖数据层
- **职责分离**: 事件管理、业务逻辑、数据操作各司其职

## 🔗 事件流连接关系优化

### **问题分析**

#### **1. 连接关系分散问题**
- **之前**: `contracts`中定义了`dependencies`，`eventFlow`中只定义了状态流转
- **问题**: 事件与依赖的关系不清晰，状态转换与业务逻辑的连接不明确

#### **2. 架构职责混乱**
- **contracts**: 应该只定义组件的基本信息（事件、状态）
- **eventFlow**: 应该定义完整的流程连接关系（trigger → event → states → dependencies → flow）

### **优化后的架构设计**

#### **contracts职责简化**
```json
"contracts": {
  "UserProfileBloc": {
    "events": ["LoadProfile", "UpdateProfile", "SaveProfile", "LoadAggregatedProfile"],
    "states": ["ProfileInitial", "ProfileLoading", "ProfileLoaded", "ProfileError", "AggregatedProfileLoaded"]
  }
}
```

#### **eventFlow职责完整**
```json
"eventFlow": {
  "LoadProfile": {
    "trigger": "页面初始化",
    "event": "LoadProfile",
    "states": ["ProfileLoading", "ProfileLoaded"],
    "dependencies": ["GetUserProfile"],
    "flow": [
      {"event": "LoadProfile", "state": "ProfileLoading"},
      {"state": "ProfileLoaded", "data": "UserProfile"}
    ]
  }
}
```

### **🏆 优化优势**

#### **1. 连接关系清晰**
- **trigger → event**: 明确触发条件到事件的映射
- **event → states**: 明确事件涉及的状态变化
- **event → dependencies**: 明确事件依赖的业务用例
- **flow**: 详细的状态转换流程

#### **2. 职责分离明确**
- **contracts**: 定义组件能力（能做什么）
- **eventFlow**: 定义组件行为（怎么做）

#### **3. 便于维护和扩展**
- 新增事件时，只需在eventFlow中添加完整的连接关系
- 修改依赖时，直接在eventFlow中调整
- 状态变化时，在flow中明确定义

### **🎯 架构设计原则**

1. **单一职责**: contracts专注定义，eventFlow专注流程
2. **完整连接**: 每个事件都有完整的trigger → event → states → dependencies → flow链条
3. **清晰边界**: 展示层的事件流不暴露领域层细节，只通过dependencies引用
4. **易于理解**: 开发人员可以快速理解事件的完整生命周期

## 🏷️ 命名规范与统一语言优化

### **当前命名问题分析**

#### **1. 查询值对象命名不一致**
- `UserProfileQueryResult` → 应该体现"查询值对象"的特性
- 需要考虑DDD中的Value Object概念
- 命名应该反映聚合视图的本质

#### **2. 参数命名不够规范**
- `UserAggregatedQueryParams` → 可以更简洁明确
- 需要考虑查询参数的语义

#### **3. 用例命名可以更清晰**
- `GetUserAggregatedProfile` → 可以更明确表达"聚合视图"的概念

### **三个命名优化版本选择**

#### **版本A: 聚合视图导向命名 (推荐指数: ⭐⭐⭐⭐⭐)**
**核心思想**: 强调"聚合视图"的概念，符合DDD中的View模式

```json
{
  "GetUserAggregatedProfile": {
    "type": "composite_query_use_case",
    "input": "UserProfileViewParams",
    "output": "Either<AppError, UserProfileAggregatedView>",
    "dependencies": ["GetUserProfile", "GetUserPreferences", "GetUserActivity"],
    "composition": {
      "userProfile": "GetUserProfile",
      "userPreferences": "GetUserPreferences", 
      "userActivity": "GetUserActivity"
    }
  }
}
```

**优势**: 
- 明确表达"聚合视图"的概念
- 符合DDD中的View模式
- 命名简洁明了

#### **版本B: 查询结果导向命名 (推荐指数: ⭐⭐⭐⭐)**
**核心思想**: 强调"查询结果"的概念，突出查询的返回值特性

```json
{
  "GetUserProfileSummary": {
    "type": "composite_query_use_case",
    "input": "UserProfileSummaryParams",
    "output": "Either<AppError, UserProfileSummary>",
    "dependencies": ["GetUserProfile", "GetUserPreferences", "GetUserActivity"],
    "composition": {
      "userProfile": "GetUserProfile",
      "userPreferences": "GetUserPreferences", 
      "userActivity": "GetUserActivity"
    }
  }
}
```

**优势**: 
- 强调"摘要"的概念
- 命名直观易懂
- 符合业务语义

#### **版本C: 组合查询导向命名 (推荐指数: ⭐⭐⭐)**
**核心思想**: 强调"组合查询"的概念，突出查询的组合特性

```json
{
  "GetUserProfileComposition": {
    "type": "composite_query_use_case",
    "input": "UserProfileCompositionParams",
    "output": "Either<AppError, UserProfileComposition>",
    "dependencies": ["GetUserProfile", "GetUserPreferences", "GetUserActivity"],
    "composition": {
      "userProfile": "GetUserProfile",
      "userPreferences": "GetUserPreferences", 
      "userActivity": "GetUserActivity"
    }
  }
}
```

**优势**: 
- 强调"组合"的概念
- 技术性较强
- 适合技术团队

### **🏆 推荐选择: 版本A (聚合视图导向)**

**选择理由**:
1. **DDD一致性**: 符合领域驱动设计中的View模式
2. **业务语义**: "聚合视图"更符合业务理解
3. **命名简洁**: 避免冗长的命名
4. **扩展性好**: 便于后续添加其他类型的视图

**统一语言规范**:
- **Use Case**: `Get[Entity][ViewType]`
- **Input**: `[Entity][ViewType]Params`
- **Output**: `[Entity][ViewType]`
- **Value Object**: 使用`View`后缀表示查询值对象

## 📚 完整统一语言规范体系

### **🏗️ 架构层次命名规范**

#### **1. 分层架构命名**
```
lib/
├── core/                           # 核心基础设施
│   ├── constants/                  # 常量定义
│   ├── theme/                      # 主题样式
│   ├── utils/                      # 工具函数
│   ├── widgets/                    # 通用组件
│   └── di/                        # 依赖注入
├── features/                       # 功能模块
│   └── [feature_name]/            # 功能名称（小写+下划线）
│       ├── data/                   # 数据层
│       ├── domain/                 # 领域层
│       └── presentation/           # 展示层
└── l10n/                          # 国际化
```

#### **2. 文件命名规范**
```
# 实体类
[EntityName].dart                   # 如: UserProfile.dart

# 用例类
[Action][EntityName].dart           # 如: GetUserProfile.dart, UpdateUserProfile.dart

# 仓储接口
[EntityName]Repository.dart         # 如: UserProfileRepository.dart

# 仓储实现
[EntityName]RepositoryImpl.dart     # 如: UserProfileRepositoryImpl.dart

# 数据模型
[EntityName]Model.dart              # 如: UserProfileModel.dart

# BLoC类
[EntityName]Bloc.dart               # 如: UserProfileBloc.dart

# 页面类
[EntityName]Page.dart               # 如: UserProfilePage.dart

# 组件类
[EntityName]Widget.dart             # 如: UserProfileWidget.dart
```

### **🎯 领域层命名规范**

#### **1. 实体 (Entity) 命名**
```dart
// 聚合根
class UserProfile extends Equatable {
  final String id;
  final String name;
  final String email;
  // ...
}

// 值对象
class Email extends Equatable {
  final String value;
  // ...
}

// 枚举
enum UserStatus { active, inactive, suspended }
```

#### **2. 用例 (Use Case) 命名**
```dart
// 查询用例
class GetUserProfile extends UseCase<UserProfile, GetUserProfileParams> {
  // ...
}

// 命令用例
class UpdateUserProfile extends UseCase<UserProfile, UpdateUserProfileParams> {
  // ...
}

// 复合查询用例
class GetUserProfileView extends UseCase<UserProfileView, GetUserProfileViewParams> {
  // ...
}
```

#### **3. 仓储接口 (Repository) 命名**
```dart
abstract class UserProfileRepository {
  Future<Either<AppError, UserProfile>> getUserProfile(String id);
  Future<Either<AppError, UserProfile>> updateUserProfile(UserProfile profile);
  Future<Either<AppError, bool>> deleteUserProfile(String id);
}
```

### **📱 展示层命名规范**

#### **1. BLoC命名规范**
```dart
// 事件命名
abstract class UserProfileEvent extends Equatable {
  const UserProfileEvent();
}

class LoadUserProfile extends UserProfileEvent {
  final String userId;
  const LoadUserProfile(this.userId);
}

class UpdateUserProfile extends UserProfileEvent {
  final UserProfile profile;
  const UpdateUserProfile(this.profile);
}

// 状态命名
abstract class UserProfileState extends Equatable {
  const UserProfileState();
}

class UserProfileInitial extends UserProfileState {}
class UserProfileLoading extends UserProfileState {}
class UserProfileLoaded extends UserProfileState {
  final UserProfile profile;
  const UserProfileLoaded(this.profile);
}
class UserProfileError extends UserProfileState {
  final String message;
  const UserProfileError(this.message);
}
```

#### **2. 页面和组件命名**
```dart
// 页面类
class UserProfilePage extends StatelessWidget {
  // ...
}

// 组件类
class UserProfileForm extends StatefulWidget {
  // ...
}

class UserProfileCard extends StatelessWidget {
  // ...
}
```

### **💾 数据层命名规范**

#### **1. 数据模型命名**
```dart
// 数据传输对象
class UserProfileModel {
  final String id;
  final String name;
  final String email;
  
  // 从实体转换
  factory UserProfileModel.fromEntity(UserProfile entity) {
    return UserProfileModel(
      id: entity.id,
      name: entity.name,
      email: entity.email,
    );
  }
  
  // 转换为实体
  UserProfile toEntity() {
    return UserProfile(
      id: id,
      name: name,
      email: email,
    );
  }
}
```

#### **2. 数据源命名**
```dart
abstract class UserProfileDataSource {
  Future<UserProfileModel> getUserProfile(String id);
  Future<UserProfileModel> updateUserProfile(UserProfileModel model);
}

class UserProfileRemoteDataSource implements UserProfileDataSource {
  // ...
}

class UserProfileLocalDataSource implements UserProfileDataSource {
  // ...
}
```

### **🔧 工具和常量命名规范**

#### **1. 错误处理命名**
```dart
abstract class AppError extends Equatable {
  final String message;
  const AppError(this.message);
}

class NetworkError extends AppError {
  const NetworkError(String message) : super(message);
}

class ValidationError extends AppError {
  const ValidationError(String message) : super(message);
}

class ServerError extends AppError {
  const ServerError(String message) : super(message);
}
```

#### **2. 常量命名**
```dart
class AppConstants {
  // API相关
  static const String baseUrl = 'https://api.example.com';
  static const String apiVersion = '/v1';
  
  // 缓存相关
  static const Duration cacheTimeout = Duration(hours: 1);
  static const String userProfileCacheKey = 'user_profile_cache';
  
  // 验证相关
  static const int maxNameLength = 50;
  static const int minPasswordLength = 8;
}
```

### **📋 契约定义命名规范**

#### **1. 查询契约命名**
```json
{
  "GetUserProfileView": {
    "type": "composite_query_use_case",
    "input": "UserProfileViewParams",
    "output": "Either<AppError, UserProfileView>",
    "dependencies": ["GetUserProfile", "GetUserPreferences", "GetUserActivity"],
    "composition": {
      "userProfile": "GetUserProfile",
      "userPreferences": "GetUserPreferences",
      "userActivity": "GetUserActivity"
    }
  }
}
```

#### **2. 命令契约命名**
```json
{
  "UpdateUserProfile": {
    "type": "command_use_case",
    "input": "UpdateUserProfileParams",
    "output": "Either<AppError, UserProfile>",
    "dependencies": ["UserProfileRepository"],
    "businessRules": ["权限验证", "数据验证", "业务规则检查"]
  }
}
```

### **🎨 样式和主题命名规范**

#### **1. 颜色命名**
```dart
class AppColors {
  // 主色调
  static const Color primary = Color(0xFF1976D2);
  static const Color primaryLight = Color(0xFF42A5F5);
  static const Color primaryDark = Color(0xFF1565C0);
  
  // 语义色彩
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color error = Color(0xFFF44336);
  
  // 中性色彩
  static const Color background = Color(0xFFFAFAFA);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
}
```

#### **2. 尺寸命名**
```dart
class AppSizes {
  // 间距
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  
  // 字体大小
  static const double textXs = 12.0;
  static const double textSm = 14.0;
  static const double textMd = 16.0;
  static const double textLg = 18.0;
  static const double textXl = 20.0;
  
  // 圆角
  static const double radiusSm = 4.0;
  static const double radiusMd = 8.0;
  static const double radiusLg = 16.0;
}
```

### **📝 注释和文档命名规范**

#### **1. 类注释模板**
```dart
/// 用户档案聚合根
/// 
/// 负责管理用户的基本信息，包括：
/// - 个人资料信息
/// - 用户偏好设置
/// - 业务规则验证
/// 
/// 示例：
/// ```dart
/// final userProfile = UserProfile(
///   id: 'user_123',
///   name: '张三',
///   email: 'zhangsan@example.com',
/// );
/// ```
class UserProfile extends Equatable {
  // ...
}
```

#### **2. 方法注释模板**
```dart
/// 获取用户档案信息
/// 
/// [userId] 用户唯一标识符
/// 
/// 返回包含用户完整信息的 [UserProfile] 对象，
/// 如果用户不存在则返回 [UserNotFoundError]
/// 
/// 示例：
/// ```dart
/// final result = await getUserProfile('user_123');
/// result.fold(
///   (error) => print('获取失败: $error'),
///   (profile) => print('用户: ${profile.name}'),
/// );
/// ```
Future<Either<AppError, UserProfile>> getUserProfile(String userId) async {
  // ...
}
```

### **🏆 命名规范检查清单**

#### **✅ 必检查项**
- [ ] 类名使用 PascalCase
- [ ] 方法名使用 camelCase
- [ ] 常量使用 SCREAMING_SNAKE_CASE
- [ ] 文件名使用 snake_case
- [ ] 私有成员使用下划线前缀

#### **✅ 语义检查项**
- [ ] 命名是否清晰表达意图
- [ ] 是否遵循领域语言
- [ ] 是否保持一致性
- [ ] 是否避免缩写和歧义

#### **✅ 架构检查项**
- [ ] 是否遵循分层架构原则
- [ ] 是否体现依赖关系
- [ ] 是否便于扩展和维护
- [ ] 是否符合SOLID原则

**从需求提炼的步骤**:
1. **分层分析**: 按Clean Architecture分层识别组件和依赖
2. **事件设计**: 设计BLoC事件流和状态转换
3. **聚合定义**: 识别聚合根、相关实体和业务规则

**优势**:
- 架构清晰：分层结构明确，依赖关系清楚
- 状态管理：事件流清晰，状态转换可追踪
- 业务聚焦：聚合边界明确，业务规则集中
- 完整覆盖：从架构到业务的全方位契约定义

## 🏆 推荐方案选择

### **🏆 最佳实践: 方案3 (聚合实体契约方案)**
- **推荐指数**: ⭐⭐⭐⭐⭐
- **核心价值**: 结合分层契约、纯展示层事件流、业务聚合和CQRS分离的完整解决方案
- **适用场景**: 复杂业务系统、需要跨聚合查询、追求架构完整性的项目
- **实施建议**: 作为主要架构方案，适用于新项目和架构重构

## 💡 实施建议

### **直接采用最佳实践**
1. **目标**: 追求架构完整性和最佳实践
2. **适用**: 新项目、有经验的团队、对架构质量要求高的项目
3. **步骤**: 采用聚合实体契约方案，建立完整的契约体系

### **实施要点**
1. **聚合设计**: 明确业务聚合边界和聚合根
2. **事件流设计**: 设计纯展示层的事件流，不跨越架构边界
3. **CQRS实施**: 分离查询和命令职责，提高系统性能
4. **契约定义**: 定义完整的契约体系，包括接口、行为和约束

## 🏠 Home功能契约定义示例

基于您项目中的home功能，以下是三种契约方案的具体描述：

### **方案1: 分层契约映射方案 - Home功能**

```json
{
  "feature": "Home页面信息管理",
  "layers": {
    "presentation": {
      "contracts": {
        "HomeBloc": {
          "events": ["LoadHomeData", "RefreshHomeData", "UpdateHomeMessage"],
          "states": ["HomeInitial", "HomeLoading", "HomeLoaded", "HomeError"],
          "dependencies": ["GetHomeMessage"],
          "responsibilities": ["状态管理", "事件处理", "业务逻辑编排"]
        },
        "HomePage": {
          "widgets": ["HomeView", "AppBar", "FloatingActionButton"],
          "dependencies": ["HomeBloc", "Theme", "Router"],
          "responsibilities": ["页面布局", "导航管理", "生命周期管理"]
        },
        "HomeWidget": {
          "type": "display_widget",
          "dependencies": ["HomeBloc"],
          "responsibilities": ["信息展示", "用户交互", "状态响应"]
        }
      }
    },
    "domain": {
      "contracts": {
        "HomeEntity": {
          "type": "aggregate_root",
          "properties": ["id", "title", "message", "createdAt", "isActive"],
          "businessRules": ["id不能为空", "title不能为空", "message不能为空"],
          "operations": ["copyWith", "defaultHome"],
          "invariants": ["实体必须有效", "创建时间不能晚于当前时间"]
        },
        "GetHomeMessage": {
          "type": "use_case",
          "input": "GetHomeMessageParams",
          "output": "Either<AppError, HomeEntity>",
          "dependencies": ["HomeRepository"],
          "businessRules": ["支持自定义消息", "错误处理", "异常捕获"],
          "responsibilities": ["获取Home数据", "处理自定义消息", "错误处理"]
        },
        "HomeRepository": {
          "type": "interface",
          "methods": [
            "getHomeData() → Either<AppError, HomeEntity>",
            "updateHomeData(HomeEntity) → Either<AppError, HomeEntity>",
            "createHomeData(HomeEntity) → Either<AppError, HomeEntity>",
            "deleteHomeData(String) → Either<AppError, bool>",
            "getAllHomeData() → Either<AppError, List<HomeEntity>>"
          ],
          "contracts": ["数据一致性", "错误处理", "异步操作"]
        }
      }
    },
    "data": {
      "contracts": {
        "HomeModel": {
          "type": "data_model",
          "properties": ["id", "title", "message", "createdAt", "isActive"],
          "mapping": "HomeEntity的DTO映射",
          "serialization": "JSON序列化支持"
        },
        "HomeRepositoryImpl": {
          "type": "implementation",
          "implements": "HomeRepository",
          "dependencies": ["HomeDataSource", "ErrorHandler"],
          "responsibilities": ["数据访问实现", "错误转换", "数据转换"]
        },
        "HomeDataSource": {
          "type": "data_source",
          "methods": ["getHomeData()", "updateHomeData()", "createHomeData()"],
          "contracts": ["数据持久化", "网络请求", "本地缓存"]
        }
      }
    }
  }
}
```

### **方案2: 事件驱动契约方案 - Home功能**

```json
{
  "feature": "Home页面信息管理",
  "eventFlow": {
    "LoadHomeData": {
      "trigger": "页面初始化或用户刷新",
      "flow": {
        "presentation": {
          "event": "LoadHomeData",
          "parameters": {"customMessage": "string?"},
          "state": "HomeLoading"
        },
        "domain": {
          "useCase": "GetHomeMessage",
          "input": "GetHomeMessageParams(customMessage)",
          "processing": "调用Repository获取数据"
        },
        "data": {
          "repository": "HomeRepository.getHomeData()",
          "dataSource": "HomeDataSource",
          "persistence": "本地存储或API调用"
        },
        "response": {
          "success": {
            "state": "HomeLoaded",
            "data": "HomeEntity",
            "ui_update": "显示Home信息"
          },
          "error": {
            "state": "HomeError",
            "message": "错误信息",
            "ui_update": "显示错误提示"
          }
        }
      }
    },
    "RefreshHomeData": {
      "trigger": "用户下拉刷新",
      "flow": {
        "presentation": {
          "event": "RefreshHomeData",
          "state": "HomeLoading"
        },
        "domain": {
          "useCase": "GetHomeMessage",
          "input": "GetHomeMessageParams()",
          "processing": "重新获取最新数据"
        },
        "data": {
          "repository": "HomeRepository.getHomeData()",
          "dataSource": "HomeDataSource",
          "cache_strategy": "忽略缓存，强制刷新"
        }
      }
    },
    "UpdateHomeMessage": {
      "trigger": "用户更新消息",
      "flow": {
        "presentation": {
          "event": "UpdateHomeMessage",
          "parameters": {"message": "string"},
          "state": "HomeLoading"
        },
        "domain": {
          "useCase": "GetHomeMessage",
          "input": "GetHomeMessageParams(customMessage: message)",
          "processing": "创建更新后的实体"
        },
        "data": {
          "repository": "HomeRepository.updateHomeData()",
          "persistence": "本地更新 + 可选API同步"
        }
      }
    }
  },
  "stateTransitions": {
    "HomeInitial": {
      "transitions": [
        {"to": "HomeLoading", "trigger": "LoadHomeData"},
        {"to": "HomeLoading", "trigger": "RefreshHomeData"}
      ]
    },
    "HomeLoading": {
      "transitions": [
        {"to": "HomeLoaded", "trigger": "数据加载成功"},
        {"to": "HomeError", "trigger": "数据加载失败"}
      ]
    },
    "HomeLoaded": {
      "transitions": [
        {"to": "HomeLoading", "trigger": "RefreshHomeData"},
        {"to": "HomeLoading", "trigger": "UpdateHomeMessage"}
      ]
    },
    "HomeError": {
      "transitions": [
        {"to": "HomeLoading", "trigger": "LoadHomeData"},
        {"to": "HomeLoading", "trigger": "RefreshHomeData"}
      ]
    }
  }
}
```

### **方案3: 聚合实体契约方案 - Home功能 (纯展示层事件流版)**

```json
{
  "feature": "Home页面信息管理",
  "layers": {
    "presentation": {
      "contracts": {
        "HomeBloc": {
          "events": ["LoadHomeData", "RefreshHomeData", "UpdateHomeMessage", "LoadAggregatedData"],
          "states": ["HomeInitial", "HomeLoading", "HomeLoaded", "HomeError", "AggregatedDataLoaded"],
          "dependencies": ["GetHomeMessage", "GetHomeAggregatedData"]
        },
        "HomePage": {
          "widgets": ["HomeView", "AppBar", "FloatingActionButton"],
          "dependencies": ["HomeBloc", "Theme", "Router"]
        }
      },
      "eventFlow": {
        "LoadHomeData": {
          "trigger": "页面初始化",
          "flow": [
            {"event": "LoadHomeData", "state": "HomeLoading"},
            {"state": "HomeLoaded", "data": "HomeEntity"}
          ]
        },
        "UpdateHomeMessage": {
          "trigger": "用户更新消息",
          "flow": [
            {"event": "UpdateHomeMessage", "state": "HomeLoading"},
            {"state": "HomeLoaded", "data": "HomeEntity"}
          ]
        },
        "LoadAggregatedData": {
          "trigger": "需要完整页面信息",
          "flow": [
            {"event": "LoadAggregatedData", "state": "HomeLoading"},
            {"state": "AggregatedDataLoaded", "data": "HomeAggregatedView"}
          ]
        }
      }
    },
    "domain": {
      "contracts": {
        "HomeEntity": {
          "type": "aggregate_root",
          "properties": ["id", "title", "message", "createdAt", "isActive"],
          "businessRules": ["id不能为空", "title不能为空", "message不能为空"]
        },
        "GetHomeMessage": {
          "type": "query_use_case",
          "input": "GetHomeMessageParams",
          "output": "Either<AppError, HomeEntity>",
          "dependencies": ["HomeRepository"],
          "responsibility": "获取Home页面基础信息"
        },
        "GetHomeAggregatedData": {
          "type": "composite_query_use_case",
          "input": "HomeViewParams",
          "output": "Either<AppError, HomeAggregatedView>",
          "dependencies": ["GetHomeMessage", "GetCurrentUser", "GetNotificationSummary"],
          "composition": {
            "homeData": "GetHomeMessage",
            "userInfo": "GetCurrentUser",
            "notifications": "GetNotificationSummary"
          },
          "responsibility": "组合多个原子查询用例",
          "businessRules": ["用户必须已登录", "数据权限验证", "聚合数据一致性检查"]
        }
      }
    },
    "data": {
      "contracts": {
        "HomeRepository": {
          "type": "interface",
          "methods": ["getHomeData", "updateHomeData", "createHomeData"]
        },
        "UserRepository": {
          "type": "interface",
          "methods": ["getCurrentUser", "getUserPreferences"]
        },
        "NotificationRepository": {
          "type": "interface",
          "methods": ["getUnreadCount", "getRecentNotifications"]
        }
      }
    }
  },
  "aggregate": {
    "root": "HomeEntity",
    "entities": ["HomeEntity"],
    "rules": [
      "id不能为空",
      "title不能为空", 
      "message不能为空",
      "支持自定义消息覆盖"
    ]
  }
}
```

**从需求提炼过程**:
1. **分层分析**: 按Clean Architecture分层识别Home功能的组件和依赖
2. **事件设计**: 设计Home功能的BLoC事件流和状态转换
3. **聚合定义**: 识别HomeEntity作为聚合根和关键业务规则

## 🔍 方案3的聚合查询优化版本

### **设计思路分析**: 在方案3基础上添加聚合查询能力

您的想法很有价值！通过添加聚合查询的use case方法，依赖多个Repository返回HomeQuery查询对象，可以实现：
- **跨聚合查询**: 从多个业务域获取数据
- **查询对象封装**: 统一的查询结果结构
- **Repository解耦**: 降低聚合间的直接依赖

### **三个优化版本推荐**

#### **版本A: 查询聚合器模式 (推荐指数: ⭐⭐⭐⭐⭐)**
**核心思想**: 创建专门的查询聚合器，协调多个Repository的查询操作

```json
{
  "feature": "Home页面聚合查询管理",
  "layers": {
    "presentation": {
      "contracts": {
        "HomeBloc": {
          "events": ["LoadHomeData", "RefreshHomeData", "UpdateHomeMessage", "LoadAggregatedData"],
          "states": ["HomeInitial", "HomeLoading", "HomeLoaded", "HomeError", "AggregatedDataLoaded"],
          "dependencies": ["GetHomeMessage", "GetHomeAggregatedData"]
        }
      }
    },
    "domain": {
      "contracts": {
        "GetHomeAggregatedData": {
          "type": "aggregated_use_case",
          "input": "HomeAggregatedQueryParams",
          "output": "Either<AppError, HomeQueryResult>",
          "dependencies": ["HomeRepository", "UserRepository", "NotificationRepository"],
          "aggregation": {
            "homeData": "HomeRepository.getHomeData",
            "userInfo": "UserRepository.getCurrentUser",
            "notifications": "NotificationRepository.getUnreadCount"
          }
        },
        "HomeQueryResult": {
          "type": "query_result",
          "properties": {
            "homeData": "HomeEntity",
            "userInfo": "UserEntity",
            "notifications": "NotificationSummary",
            "lastUpdated": "DateTime"
          }
        }
      }
    },
    "data": {
      "contracts": {
        "HomeRepository": {"methods": ["getHomeData", "updateHomeData"]},
        "UserRepository": {"methods": ["getCurrentUser", "getUserPreferences"]},
        "NotificationRepository": {"methods": ["getUnreadCount", "getRecentNotifications"]}
      }
    }
  }
}
```

**优势**: 查询逻辑集中，易于维护，支持复杂的跨聚合查询
**适用**: 需要从多个业务域聚合数据的场景

#### **版本B: 事件驱动聚合查询 (推荐指数: ⭐⭐⭐⭐)**
**核心思想**: 通过事件驱动的方式，让各个Repository异步推送数据到查询服务

```json
{
  "feature": "Home页面实时聚合查询",
  "layers": {
    "presentation": {
      "contracts": {
        "HomeBloc": {
          "events": ["LoadHomeData", "SubscribeToAggregatedData", "UnsubscribeFromAggregatedData"],
          "states": ["HomeInitial", "HomeLoading", "HomeLoaded", "HomeError", "AggregatedDataStreaming"],
          "dependencies": ["GetHomeMessage", "SubscribeHomeAggregatedData"]
        }
      }
    },
    "domain": {
      "contracts": {
        "SubscribeHomeAggregatedData": {
          "type": "streaming_use_case",
          "input": "HomeAggregatedSubscriptionParams",
          "output": "Stream<Either<AppError, HomeQueryResult>>",
          "dependencies": ["HomeRepository", "UserRepository", "NotificationRepository"],
          "eventStreams": {
            "homeDataStream": "HomeRepository.homeDataChanges",
            "userInfoStream": "UserRepository.userInfoChanges",
            "notificationStream": "NotificationRepository.notificationUpdates"
          }
        }
      }
    }
  }
}
```

**优势**: 实时性好，支持数据流聚合，响应速度快
**适用**: 需要实时数据更新的查询场景

#### **版本C: 视图聚合模式 (推荐指数: ⭐⭐⭐)**
**核心思想**: 创建专门的视图聚合，预计算和存储跨聚合的查询结果

```json
{
  "feature": "Home页面视图聚合查询",
  "layers": {
    "presentation": {
      "contracts": {
        "HomeBloc": {
          "events": ["LoadHomeData", "LoadHomeView", "RefreshHomeView"],
          "states": ["HomeInitial", "HomeLoading", "HomeLoaded", "HomeError", "HomeViewLoaded"],
          "dependencies": ["GetHomeMessage", "GetHomeView"]
        }
      }
    },
    "domain": {
      "contracts": {
        "GetHomeView": {
          "type": "view_use_case",
          "input": "HomeViewParams",
          "output": "Either<AppError, HomeViewResult>",
          "dependencies": ["HomeViewRepository"],
          "viewDefinition": {
            "name": "HomePageView",
            "updateStrategy": "定时更新 + 事件触发",
            "sourceAggregates": ["HomeEntity", "UserEntity", "NotificationEntity"]
          }
        },
        "HomeViewResult": {
          "type": "view_result",
          "properties": {
            "homeData": "HomeEntity",
            "userInfo": "UserEntity",
            "notifications": "NotificationSummary",
            "systemStatus": "SystemStatus",
            "lastUpdated": "DateTime"
          }
        }
      }
    },
    "data": {
      "contracts": {
        "HomeViewRepository": {
          "type": "view_repository",
          "methods": ["getHomeView", "refreshHomeView", "subscribeToUpdates"],
          "dataSource": "预计算的视图数据 + 实时更新"
        }
      }
    }
  }
}
```

**优势**: 查询性能高，支持复杂的分析查询，数据一致性好
**适用**: 对性能要求高，数据更新频率不高的场景

## 🎯 Home功能契约方案对比

### **方案1优势**:
- 完全符合您的Clean Architecture分层结构
- 每层职责清晰，依赖关系明确
- 易于理解和维护

### **方案2优势**:
- 完美匹配BLoC的事件驱动特性
- 事件流和状态转换清晰可见
- 支持复杂的状态管理场景

### **方案3优势**:
- 业务边界清晰，实体关系明确
- 业务规则集中管理
- 支持复杂的业务逻辑建模

这三种方案为您的Home功能提供了完整的契约定义，可以根据项目需求选择最适合的方案或组合使用。

## 🚀 方案3的最佳应用场景推荐

### **🏆 场景1: 电商订单管理系统 (推荐指数: ⭐⭐⭐⭐⭐)**

**业务特点**: 涉及用户、商品、订单、支付、物流等多个聚合
**方案3优势**: 完美支持跨聚合的复杂查询和业务规则

```json
{
  "feature": "订单管理聚合查询",
  "layers": {
    "presentation": {
      "contracts": {
        "OrderBloc": {
          "events": ["LoadOrder", "CreateOrder", "UpdateOrder", "LoadOrderAggregated"],
          "states": ["OrderInitial", "OrderLoading", "OrderLoaded", "OrderError", "OrderAggregatedLoaded"],
          "dependencies": ["GetOrder", "CreateOrder", "GetOrderAggregated"]
        }
      }
    },
    "domain": {
      "contracts": {
        "GetOrderAggregated": {
          "type": "aggregated_use_case",
          "input": "OrderAggregatedQueryParams",
          "output": "Either<AppError, OrderAggregatedResult>",
          "dependencies": ["OrderRepository", "UserRepository", "ProductRepository", "PaymentRepository"],
          "aggregation": {
            "order": "OrderRepository.getOrder",
            "user": "UserRepository.getUser",
            "products": "ProductRepository.getProducts",
            "payment": "PaymentRepository.getPaymentStatus"
          }
        }
      }
    }
  },
  "queryAggregator": {
    "name": "OrderAggregator",
    "aggregates": ["Order", "User", "Product", "Payment"],
    "queries": {
      "getOrderAggregated": {
        "businessRules": ["用户权限验证", "订单状态一致性", "支付状态验证"]
      }
    }
  }
}
```

### **🏆 场景2: 用户权限管理系统 (推荐指数: ⭐⭐⭐⭐⭐)**

**业务特点**: 用户、角色、权限、组织等多维度权限控制
**方案3优势**: 支持复杂的权限聚合和动态权限计算

```json
{
  "feature": "用户权限聚合查询",
  "layers": {
    "domain": {
      "contracts": {
        "GetUserPermissions": {
          "type": "aggregated_use_case",
          "input": "UserPermissionQueryParams",
          "output": "Either<AppError, UserPermissionResult>",
          "dependencies": ["UserRepository", "RoleRepository", "PermissionRepository", "OrganizationRepository"],
          "aggregation": {
            "user": "UserRepository.getUser",
            "roles": "RoleRepository.getUserRoles",
            "permissions": "PermissionRepository.getRolePermissions",
            "organization": "OrganizationRepository.getUserOrganization"
          }
        }
      }
    }
  },
  "queryAggregator": {
    "name": "PermissionAggregator",
    "aggregates": ["User", "Role", "Permission", "Organization"],
    "queries": {
      "getUserPermissions": {
        "businessRules": ["权限继承计算", "组织权限验证", "动态权限更新"]
      }
    }
  }
}
```

### **🏆 场景3: 数据分析仪表板 (推荐指数: ⭐⭐⭐⭐)**

**业务特点**: 需要从多个数据源聚合数据，支持实时更新
**方案3优势**: 查询聚合器模式适合复杂的数据聚合场景

```json
{
  "feature": "数据分析仪表板",
  "layers": {
    "domain": {
      "contracts": {
        "GetDashboardData": {
          "type": "aggregated_use_case",
          "input": "DashboardQueryParams",
          "output": "Either<AppError, DashboardResult>",
          "dependencies": ["SalesRepository", "UserRepository", "ProductRepository", "AnalyticsRepository"],
          "aggregation": {
            "sales": "SalesRepository.getSalesData",
            "users": "UserRepository.getUserStats",
            "products": "ProductRepository.getProductMetrics",
            "analytics": "AnalyticsRepository.getAnalyticsData"
          }
        }
      }
    }
  },
  "queryAggregator": {
    "name": "DashboardAggregator",
    "aggregates": ["Sales", "User", "Product", "Analytics"],
    "queries": {
      "getDashboardData": {
        "businessRules": ["数据权限控制", "实时数据更新", "缓存策略"]
      }
    }
  }
}
```

### **🏆 场景4: 工作流管理系统 (推荐指数: ⭐⭐⭐⭐)**

**业务特点**: 流程定义、实例执行、状态跟踪等多维度管理
**方案3优势**: 支持复杂的工作流状态聚合和规则验证

```json
{
  "feature": "工作流聚合查询",
  "layers": {
    "domain": {
      "contracts": {
        "GetWorkflowStatus": {
          "type": "aggregated_use_case",
          "input": "WorkflowStatusQueryParams",
          "output": "Either<AppError, WorkflowStatusResult>",
          "dependencies": ["WorkflowRepository", "TaskRepository", "UserRepository", "ApprovalRepository"],
          "aggregation": {
            "workflow": "WorkflowRepository.getWorkflow",
            "tasks": "TaskRepository.getActiveTasks",
            "assignees": "UserRepository.getTaskAssignees",
            "approvals": "ApprovalRepository.getPendingApprovals"
          }
        }
      }
    }
  },
  "queryAggregator": {
    "name": "WorkflowAggregator",
    "aggregates": ["Workflow", "Task", "User", "Approval"],
    "queries": {
      "getWorkflowStatus": {
        "businessRules": ["工作流状态一致性", "任务依赖验证", "权限控制"]
      }
    }
  }
}
```

## 💡 方案3的通用优化建议

### **1. 聚合粒度控制**
- **细粒度聚合**: 针对简单查询，保持单一聚合
- **粗粒度聚合**: 针对复杂查询，使用查询聚合器
- **动态聚合**: 根据查询参数动态选择聚合策略

### **2. 性能优化策略**
- **缓存策略**: 在查询聚合器中实现智能缓存
- **异步聚合**: 支持并行查询多个Repository
- **分页聚合**: 支持大数据量的分页聚合查询

### **3. 错误处理增强**
- **降级策略**: 某个Repository失败时的降级处理
- **重试机制**: 网络异常时的自动重试
- **部分成功**: 支持部分数据成功时的结果返回

### **4. 扩展性设计**
- **插件化聚合器**: 支持动态添加新的聚合逻辑
- **配置化查询**: 通过配置文件定义聚合规则
- **监控和指标**: 聚合查询的性能监控和统计

## 🔍 "Boundaries"概念详解

### **什么是Boundaries（边界）？**

在聚合实体契约方案中，"boundaries"定义了业务聚合的边界，包括：

#### **1. 输入边界 (Input Boundaries)**
定义聚合如何接收外部输入：
- **用户交互**: 用户的操作行为（点击、输入、手势）
- **系统事件**: 应用内部的状态变化（启动、配置更新）
- **外部请求**: 来自其他系统或服务的数据请求

#### **2. 输出边界 (Output Boundaries)**
定义聚合如何向外部输出：
- **UI更新**: 界面状态的更新和显示
- **数据操作**: 数据的持久化和同步
- **事件发布**: 业务事件的广播和通知

#### **3. 架构约束 (Architectural Constraints)**
定义聚合必须遵循的技术约束：
- **依赖注入**: 所有依赖必须通过容器管理
- **错误边界**: 错误必须在边界内处理
- **不可变性**: 状态对象不能直接修改
- **单一职责**: 每个组件只做一件事
- **接口隔离**: 接口要小而专注

#### **4. 业务边界 (Business Boundaries)**
定义聚合的业务规则和约束：
- **聚合根**: 作为业务聚合的唯一入口点
- **不变性保护**: 业务规则必须强制执行
- **事务边界**: 相关操作必须在同一事务内
- **一致性边界**: 聚合内数据必须保持一致

### **为什么Boundaries很重要？**

#### **业务价值**:
- **清晰性**: 明确业务聚合的职责范围
- **一致性**: 确保业务规则得到强制执行
- **可维护性**: 边界清晰，易于理解和修改
- **可测试性**: 边界明确，便于单元测试

#### **技术价值**:
- **解耦**: 减少组件间的直接依赖
- **可扩展**: 边界清晰，易于添加新功能
- **可重用**: 边界明确，便于组件重用
- **性能**: 边界控制，避免不必要的操作

### **实际应用示例**

以Home功能为例：
```
HomeInformation聚合的边界:
├── 输入边界: 用户点击刷新、系统启动、网络请求
├── 输出边界: 页面更新、数据保存、状态通知
├── 架构约束: DI注入、错误处理、状态不可变
└── 业务边界: 聚合根控制、规则强制执行、数据一致性
```

这样的边界定义让Home功能成为一个完整的、自包含的业务单元，既保证了业务逻辑的完整性，又确保了技术实现的规范性。

## 🌐 Boundaries的通用性分析

### **通用性程度评估**

#### **高度通用 (High Reusability)**
- **架构约束**: 依赖注入、错误处理、状态不可变等原则
- **输入边界**: 用户交互、系统事件、外部请求的基本模式
- **输出边界**: UI更新、数据操作、事件发布的基本模式

#### **中等通用 (Medium Reusability)**  
- **业务边界**: 聚合根、事务边界、一致性边界等概念
- **验证规则**: 基本的参数验证、权限检查等

#### **低度通用 (Low Reusability)**
- **具体业务规则**: 特定领域的业务逻辑和约束
- **UI组件**: 具体的页面和控件实现

### **通用边界框架设计**

```json
{
  "genericBoundaries": {
    "input_boundaries": {
      "user_interactions": {
        "pattern": "用户操作模式",
        "examples": ["点击事件", "表单输入", "手势操作", "键盘输入"],
        "reusable": true,
        "customization": "具体的事件类型和参数"
      },
      "system_events": {
        "pattern": "系统事件模式", 
        "examples": ["应用启动", "生命周期变化", "配置更新", "网络状态变化"],
        "reusable": true,
        "customization": "具体的系统事件类型"
      },
      "external_requests": {
        "pattern": "外部请求模式",
        "examples": ["网络API调用", "本地存储访问", "设备信息获取", "第三方服务调用"],
        "reusable": true,
        "customization": "具体的请求类型和参数"
      }
    },
    "output_boundaries": {
      "ui_updates": {
        "pattern": "UI更新模式",
        "examples": ["页面刷新", "状态显示", "错误提示", "加载指示"],
        "reusable": true,
        "customization": "具体的UI组件和更新逻辑"
      },
      "data_operations": {
        "pattern": "数据操作模式",
        "examples": ["数据保存", "缓存更新", "同步操作", "数据清理"],
        "reusable": true,
        "customization": "具体的数据类型和操作逻辑"
      },
      "event_publishing": {
        "pattern": "事件发布模式",
        "examples": ["状态变化通知", "业务事件广播", "日志记录", "性能监控"],
        "reusable": true,
        "customization": "具体的事件类型和发布逻辑"
      }
    },
    "architectural_constraints": {
      "dependency_injection": {
        "pattern": "依赖注入模式",
        "rule": "所有依赖必须通过DI容器注入",
        "reusable": true,
        "implementation": "GetIt或其他DI框架"
      },
      "error_boundaries": {
        "pattern": "错误边界模式",
        "rule": "错误必须在边界内处理，不能向外传播",
        "reusable": true,
        "implementation": "Either类型或Result模式"
      },
      "immutability": {
        "pattern": "不可变性模式",
        "rule": "状态对象必须不可变，通过copyWith更新",
        "reusable": true,
        "implementation": "Equatable + copyWith方法"
      },
      "single_responsibility": {
        "pattern": "单一职责模式",
        "rule": "每个组件只负责单一职责",
        "reusable": true,
        "implementation": "类的职责划分和接口设计"
      },
      "interface_segregation": {
        "pattern": "接口隔离模式",
        "rule": "接口必须小而专注，避免大而全",
        "reusable": true,
        "implementation": "接口拆分和组合"
      }
    },
    "business_boundaries": {
      "aggregate_root": {
        "pattern": "聚合根模式",
        "rule": "作为业务聚合的唯一入口点",
        "reusable": true,
        "customization": "具体的聚合根实体"
      },
      "invariant_protection": {
        "pattern": "不变性保护模式",
        "rule": "业务规则必须在聚合边界内强制执行",
        "reusable": true,
        "customization": "具体的业务规则"
      },
      "transaction_boundary": {
        "pattern": "事务边界模式",
        "rule": "相关操作必须在同一事务内完成",
        "reusable": true,
        "customization": "具体的事务范围"
      },
      "consistency_boundary": {
        "pattern": "一致性边界模式",
        "rule": "聚合内的数据必须保持一致",
        "reusable": true,
        "customization": "具体的一致性规则"
      }
    }
  }
}
```

### **跨业务场景的边界复用**

#### **用户管理场景**
```json
{
  "UserManagement": {
    "extends": "genericBoundaries",
    "customizations": {
      "input_boundaries": {
        "user_interactions": ["登录", "注册", "密码重置", "个人信息编辑"],
        "system_events": ["用户认证状态变化", "权限更新"],
        "external_requests": ["身份验证API", "用户数据API"]
      },
      "business_boundaries": {
        "invariant_protection": ["邮箱格式验证", "密码强度要求", "用户名唯一性"],
        "consistency_boundary": ["用户信息与权限信息一致"]
      }
    }
  }
}
```

#### **订单管理场景**
```json
{
  "OrderManagement": {
    "extends": "genericBoundaries", 
    "customizations": {
      "input_boundaries": {
        "user_interactions": ["添加商品", "修改数量", "选择支付方式", "确认订单"],
        "system_events": ["库存变化", "价格更新", "支付状态变化"],
        "external_requests": ["库存API", "支付API", "物流API"]
      },
      "business_boundaries": {
        "invariant_protection": ["库存充足", "价格有效", "支付方式支持"],
        "consistency_boundary": ["订单状态与库存状态一致"]
      }
    }
  }
}
```

### **边界模板系统**

#### **基础边界模板**
```dart
abstract class BaseBoundaries {
  // 输入边界
  List<String> get userInteractions;
  List<String> get systemEvents;
  List<String> get externalRequests;
  
  // 输出边界
  List<String> get uiUpdates;
  List<String> get dataOperations;
  List<String> get eventPublishing;
  
  // 架构约束
  List<String> get architecturalConstraints;
  
  // 业务边界
  List<String> get businessBoundaries;
}
```

#### **具体业务边界实现**
```dart
class HomeBoundaries extends BaseBoundaries {
  @override
  List<String> get userInteractions => [
    '点击刷新', '输入消息', '保存设置'
  ];
  
  @override
  List<String> get businessBoundaries => [
    '消息格式验证', '数据一致性保证'
  ];
  
  // 其他边界实现...
}
```

### **通用性的实际价值**

#### **开发效率提升**
- **模板复用**: 新功能可以基于现有边界模板快速开发
- **一致性保证**: 所有功能都遵循相同的边界模式
- **维护简化**: 边界模式统一，便于理解和维护

#### **架构演进支持**
- **渐进式改进**: 可以逐步优化边界模式
- **标准化**: 边界模式可以成为团队标准
- **知识传承**: 新团队成员可以快速理解边界概念

#### **扩展性增强**
- **新业务场景**: 可以快速应用边界模式到新功能
- **技术升级**: 边界模式与技术实现解耦，便于技术升级
- **跨项目复用**: 边界模式可以在不同项目间复用

### **总结**

**Boundaries概念具有很高的通用性**，主要体现在：

1. **架构层面**: 依赖注入、错误处理等原则适用于所有业务场景
2. **模式层面**: 输入输出边界的基本模式可以跨业务复用
3. **约束层面**: 业务边界的基本概念（聚合根、一致性等）具有通用性

**建议**: 建立边界模板系统，将通用部分抽象为模板，具体业务场景通过继承和定制来复用，这样既能保证一致性，又能满足个性化需求。

