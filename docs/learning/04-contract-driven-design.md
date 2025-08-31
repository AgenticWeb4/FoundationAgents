# 契约驱动设计 (Contract-Driven Design)

## 🎯 核心理念

契约驱动设计是一种**以业务价值为核心**的软件开发方法，通过定义清晰的业务契约来指导系统设计和实现。

### **核心价值主张**
```
业务价值 → 业务契约 → 技术契约 → 代码实现
├── 业务价值: 解决什么业务问题，创造什么价值
├── 业务契约: 业务规则、约束和协作关系
├── 技术契约: 技术接口、行为和状态管理
└── 代码实现: 具体的代码实现
```

## 🤔 为什么要契约驱动代码生成？

### **传统代码生成的痛点** 🚫

**痛点1：大模型理解障碍**
```
传统架构文档：
"UserBloc extends Bloc<UserEvent, UserState> {
  on<LoadUserEvent>(_onLoadUser);
}"

大模型理解困难：
❌ 无法理解业务逻辑
❌ 无法理解组件关系  
❌ 无法理解架构意图
```

**痛点2：代码生成质量低**
```
大模型生成的代码：
- 缺乏业务上下文
- 不符合架构规范
- 需要大量人工修改
- 维护成本高
```

**痛点3：个人开发效率低**
```
个人开发者面临的挑战：
- 架构文档晦涩难懂，自己都容易忘记
- 业务逻辑分散，重构时找不到边界
- 代码结构混乱，维护成本高
- 新功能开发时，需要重新理解旧代码
```

### **契约驱动的解决方案** 💡

**为什么选择契约驱动？**

1. **语义化表达** 🎯
   - 用业务语言描述技术架构
   - 大模型能理解业务意图
   - 减少歧义和误解

2. **结构化定义** 🏗️
   - 清晰的层次结构
   - 明确的依赖关系
   - 标准化的命名规范

3. **个人开发友好** 🌉
   - 架构意图清晰，自己不会忘记
   - 业务逻辑集中，重构时容易找到边界
   - 代码结构规范，维护成本低

### **实际效果对比** ⚖️

**传统方式**：
```
大模型输入："帮我生成用户管理的代码"
大模型输出：基础CRUD代码，缺乏业务逻辑
人工修改：需要大量调整，成本高
```

**契约驱动方式**：
```
大模型输入：完整的业务契约定义
大模型输出：符合业务逻辑的完整代码
人工修改：少量微调，成本低
```

**代码生成质量提升** 📈

**传统方式代码生成**：
```dart
// 大模型生成的代码，缺乏业务上下文
class UserBloc extends Bloc<UserEvent, UserState> {
  // 需要大量人工修改
}
```

**契约驱动代码生成**：
```dart
// 大模型基于契约生成的代码，业务逻辑清晰
class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  // 符合业务契约，维护成本低
}
```

## 🏗️ 架构映射指导

基于Clean Architecture + BLoC模式，建立清晰的映射关系：

### **需求到架构要素映射**
```
用户故事 → 业务契约 → 技术契约 → 代码实现
├── 用户故事: "作为[角色]，我想要[功能]，以便[价值]"
├── 业务契约: 业务规则、约束、协作
├── 技术契约: 接口、行为、状态
└── 代码实现: 具体的代码实现
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

## 🎯 推荐契约方案

### **🏆 最佳实践: 聚合实体契约方案**

结合分层契约的清晰架构、纯展示层的事件流管理，以及CQRS的查询命令分离原则。

#### **核心架构**
```json
{
  "feature": "用户信息管理",
  "layers": {
  "presentation": {
    "contracts": {
      "UserProfileBloc": {
        "events": ["LoadProfile", "UpdateProfile", "SaveProfile", "LoadAggregatedProfile"],
          "states": ["ProfileInitial", "ProfileLoading", "ProfileLoaded", "ProfileError", "AggregatedProfileLoaded"]
      }
    },
    "eventFlow": {
      "LoadProfile": {
        "trigger": "页面初始化",
        "flow": [
          {"event": "LoadProfile", "state": "ProfileLoading"},
          {"state": "ProfileLoaded", "data": "UserProfile"}
          ]
        }
      }
    },
    "domain": {
      "contracts": {
        "UserProfile": {
          "type": "aggregate_root",
          "properties": ["id", "name", "email", "phone"],
          "businessRules": ["email必须有效", "name不能为空"]
        },
        "GetUserProfile": {
          "type": "query_use_case",
          "input": "GetUserProfileParams",
          "output": "Either<AppError, UserProfile>",
          "dependencies": ["UserProfileRepository"]
        },
  "GetUserAggregatedProfile": {
    "type": "composite_query_use_case",
    "input": "UserProfileViewParams",
    "output": "Either<AppError, UserProfileAggregatedView>",
          "dependencies": ["GetUserProfile", "GetUserPreferences", "GetUserActivity"]
        }
      }
    },
    "data": {
      "contracts": {
        "UserProfileRepository": {
          "methods": ["getProfile", "updateProfile", "deleteProfile"]
        }
      }
    }
  }
}
```

#### **关键设计原则**
1. **纯展示层事件流**: 事件流完全在展示层内，不跨越架构边界
2. **CQRS分离**: 查询和命令职责分离，提高系统性能
3. **聚合边界**: 明确的业务聚合边界和聚合根
4. **依赖清晰**: 展示层依赖领域层，领域层依赖数据层

## 🏷️ 命名规范

### **统一语言规范**
- **Use Case**: `Get[Entity][ViewType]`
- **Input**: `[Entity][ViewType]Params`
- **Output**: `[Entity][ViewType]`
- **Value Object**: 使用`View`后缀表示查询值对象

### **文件命名规范**
```
# 实体类
[EntityName].dart                   # 如: UserProfile.dart

# 用例类
[Action][EntityName].dart           # 如: GetUserProfile.dart

# 仓储接口
[EntityName]Repository.dart         # 如: UserProfileRepository.dart

# BLoC类
[EntityName]Bloc.dart               # 如: UserProfileBloc.dart

# 页面类
[EntityName]Page.dart               # 如: UserProfilePage.dart
```

## 🏠 实际应用示例

### **Home功能契约定义**
```json
{
  "feature": "Home页面信息管理",
  "layers": {
    "presentation": {
      "contracts": {
        "HomeBloc": {
          "events": ["LoadHomeData", "RefreshHomeData", "UpdateHomeMessage"],
          "states": ["HomeInitial", "HomeLoading", "HomeLoaded", "HomeError"]
        }
      },
      "eventFlow": {
        "LoadHomeData": {
          "trigger": "页面初始化",
          "flow": [
            {"event": "LoadHomeData", "state": "HomeLoading"},
            {"state": "HomeLoaded", "data": "HomeEntity"}
          ]
        }
      }
    },
    "domain": {
      "contracts": {
        "HomeEntity": {
          "type": "aggregate_root",
          "properties": ["id", "title", "message", "createdAt"],
          "businessRules": ["id不能为空", "title不能为空", "message不能为空"]
        },
        "GetHomeMessage": {
          "type": "query_use_case",
          "input": "GetHomeMessageParams",
          "output": "Either<AppError, HomeEntity>",
          "dependencies": ["HomeRepository"]
        }
      }
    },
    "data": {
      "contracts": {
        "HomeRepository": {
          "methods": ["getHomeData", "updateHomeData", "createHomeData"]
        }
      }
    }
  }
}
```

## 💡 实施建议

### **渐进式实施策略**
```
阶段1: 基础架构
├── 建立分层契约基础
├── 团队熟悉架构原则
└── 完成核心功能开发

阶段2: 状态优化
├── 保持分层契约结构
├── 引入事件驱动契约
└── 优化复杂状态管理

阶段3: 业务深化
├── 保持架构一致性
├── 引入聚合实体契约
└── 优化复杂业务逻辑
```

### **适用场景选择**
- **简单CRUD功能**: 使用基础分层契约
- **复杂状态管理**: 引入事件驱动契约
- **复杂业务逻辑**: 使用聚合实体契约

### **个人开发能力评估**
- **初级开发者**: 从基础架构开始，逐步学习
- **中级开发者**: 可以同时使用分层和事件驱动契约
- **高级开发者**: 可以灵活组合三种方案

## 🔍 核心优势

1. **架构清晰**: 分层结构明确，依赖关系清楚
2. **状态管理**: 事件流清晰，状态转换可追踪
3. **业务聚焦**: 聚合边界明确，业务规则集中
4. **完整覆盖**: 从架构到业务的全方位契约定义
5. **易于维护**: 清晰的契约让系统更易维护和扩展
6. **大模型友好**: AI能快速理解架构意图，代码生成质量高

