# 架构契约规范 (Architecture Contract Specification)

## 🎯 设计理念

### **什么是架构契约？**

架构契约是大模型与人类架构师对齐的**中间语言**，通过标准化的契约定义来指导系统设计和实现。

#### **核心价值**
```
自然语言需求 → 架构契约 → 代码实现
├── 自然语言: 业务需求描述
├── 架构契约: 标准化的架构规范
└── 代码实现: 具体的代码实现
```

### **为什么需要架构契约？**

#### **1. 大模型对齐**
- **标准化沟通**: 提供大模型与人类架构师的标准沟通语言
- **减少歧义**: 避免自然语言理解偏差
- **提高效率**: 快速从需求到架构的转换

#### **2. 架构一致性**
- **统一规范**: 确保所有架构设计遵循统一标准
- **可维护性**: 清晰的契约让系统更易维护
- **可扩展性**: 契约为系统扩展提供清晰边界

#### **3. 开发效率**
- **快速实现**: 从契约直接生成代码框架
- **质量保证**: 契约确保实现质量
- **团队协作**: 统一的架构语言提高协作效率

## 📋 自然语言到架构契约映射

### **映射示例**

#### **自然语言提示词**
```
"用户需要能够查看和编辑个人资料信息，包括姓名、邮箱、电话等基本信息"
```

#### **对应的架构契约**
```json
{
  "feature": "用户信息管理",
  "layers": {
    "presentation": {
      "contracts": {
        "UserProfilePage": {
          "uiComponents": ["ProfileForm", "ProfileDisplay"],
          "stateProvider": ["UserProfileBloc"]
        },
        "UserProfileBloc": {
          "businessScenarios": {
            "LoadProfile": "用户打开个人资料页面",
            "UpdateProfile": "用户点击编辑按钮",
            "SaveProfile": "用户点击保存按钮"
          },
          "eventHandlers": ["LoadProfile", "UpdateProfile", "SaveProfile"],
          "stateOutputs": ["ProfileInitial", "ProfileLoading", "ProfileLoaded", "ProfileEditing", "ProfileSaving", "ProfileError"],
          "domainServices": ["GetUserProfile", "UpdateUserProfile"]
        }
      }
    }
  }
}
```

## 🏗️ 架构契约核心原理

### **1. 分层架构原则**
```
presentation (展示层)
├── uiComponents: UI组件定义
├── stateProvider: 状态提供者
└── businessScenarios: 业务场景

domain (领域层)  
├── aggregateRoot: 聚合根
├── useCase: 用例
└── businessRules: 业务规则

data (数据层)
├── repository: 仓储接口
├── dataModel: 数据模型
└── dataSource: 数据源
```

### **2. 契约命名规范**
- **uiComponents**: UI组件列表
- **stateProvider**: 状态提供者
- **businessScenarios**: 业务场景描述
- **eventHandlers**: 事件处理器
- **stateOutputs**: 状态输出
- **domainServices**: 领域服务

## 🎯 架构映射指导

### **自然语言到架构契约的转换流程**

#### **步骤1: 需求分析**
```
自然语言: "用户需要能够查看和编辑个人资料"
↓
业务场景: 查看资料、编辑资料、保存资料
```

#### **步骤2: 架构设计**
```
业务场景 → 架构层次
├── 查看资料 → presentation层 + domain层
├── 编辑资料 → presentation层 + domain层  
└── 保存资料 → domain层 + data层
```

#### **步骤3: 契约定义**
```
架构层次 → 契约结构
├── presentation → uiComponents + stateProvider + businessScenarios
├── domain → aggregateRoot + useCase + businessRules
└── data → repository + dataModel + dataSource
```

## 🏗️ 架构契约分层图

### **分层架构图**

```
自然语言需求
└── "用户需要能够查看和编辑个人资料信息"

架构契约
├── Presentation Layer (展示层)
│   ├── UserProfilePage
│   │   ├── uiComponents: [ProfileForm, ProfileDisplay]
│   │   └── stateProvider: [UserProfileBloc]
│   └── UserProfileBloc
│       ├── businessScenarios: {LoadProfile, UpdateProfile, SaveProfile}
│       ├── eventHandlers: [LoadProfile, UpdateProfile, SaveProfile]
│       ├── stateOutputs: [ProfileInitial, ProfileLoading, ProfileLoaded, ProfileEditing, ProfileSaving, ProfileError]
│       └── domainServices: [GetUserProfile, UpdateUserProfile]
│
├── Domain Layer (领域层)
│   ├── UserProfile
│   │   ├── type: aggregate_root
│   │   ├── properties: [id, name, email, phone]
│   │   └── businessRules: [email必须有效, name不能为空]
│   └── GetUserProfile
│       ├── type: use_case
│       ├── input: GetUserProfileParams
│       └── output: Either<AppError, UserProfile>
│
└── Data Layer (数据层)
    ├── UserProfileRepository
    │   ├── type: interface
    │   └── methods: [getProfile, updateProfile, deleteProfile]
    └── UserProfileModel
        ├── type: data_model
        └── properties: [id, name, email, phone]

依赖关系
UserProfilePage → UserProfileBloc → GetUserProfile → UserProfileRepository → UserProfileModel
```

### **BLoC + Clean Architecture架构图**

```
┌─────────────────────────────────────────────────────────┐
│                 BLoC + Clean Architecture               │
└─────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────┐
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐     │
│  │ Presentation│  │   Domain    │  │    Data     │     │
│  │             │  │             │  │             │     │
│  │ • BLoC      │  │ • Entity    │  │ • Repository│     │
│  │ • Events    │  │ • Use Case  │  │ • Model     │     │
│  │ • States    │  │ • Rules     │  │ • Source    │     │
│  │ • Widgets   │  │ • Logic     │  │ • API       │     │
│  └─────────────┘  └─────────────┘  └─────────────┘     │
└─────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────┐
│            BLoC Pattern + Clean Architecture            │
│  UI → BLoC → Use Case → Repository → Data Source       │
└─────────────────────────────────────────────────────────┘
```

## 📝 完整架构契约示例

### **用户信息管理功能**

#### **自然语言需求**
```
"用户需要能够查看和编辑个人资料信息，包括姓名、邮箱、电话等基本信息，支持实时保存和错误处理"
```

#### **架构契约定义**
```json
{
  "feature": "用户信息管理",
  "layers": {
    "presentation": {
      "contracts": {
        "UserProfilePage": {
          "uiComponents": ["ProfileForm", "ProfileDisplay"],
          "stateProvider": ["UserProfileBloc"]
        },
        "UserProfileBloc": {
          "businessScenarios": {
            "LoadProfile": "用户打开个人资料页面",
            "UpdateProfile": "用户点击编辑按钮",
            "SaveProfile": "用户点击保存按钮"
          },
          "eventHandlers": ["LoadProfile", "UpdateProfile", "SaveProfile"],
          "stateOutputs": ["ProfileInitial", "ProfileLoading", "ProfileLoaded", "ProfileEditing", "ProfileSaving", "ProfileError"],
          "domainServices": ["GetUserProfile", "UpdateUserProfile"]
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

## 🚀 使用指南

### **如何使用架构契约**

#### **1. 需求输入**
```
自然语言: "用户需要能够查看和编辑个人资料信息"
```

#### **2. 契约生成**
```
架构契约: 按照标准格式定义presentation、domain、data三层契约
```

#### **3. 代码实现**
```
代码实现: 基于契约生成对应的Flutter代码结构
```

### **契约命名规范总结**

| 层级 | 节点名称 | 含义 | 示例 |
|------|----------|------|------|
| **presentation** | uiComponents | UI组件列表 | ["ProfileForm", "ProfileDisplay"] |
| | stateProvider | 状态提供者 | ["UserProfileBloc"] |
| | businessScenarios | 业务场景 | {"LoadProfile": "用户打开页面"} |
| | eventHandlers | 事件处理器 | ["LoadProfile", "UpdateProfile"] |
| | stateOutputs | 状态输出 | ["ProfileLoading", "ProfileLoaded"] |
| | domainServices | 领域服务 | ["GetUserProfile", "UpdateUserProfile"] |
| **domain** | aggregateRoot | 聚合根 | UserProfile |
| | useCase | 用例 | GetUserProfile |
| | businessRules | 业务规则 | ["email必须有效"] |
| **data** | repository | 仓储接口 | UserProfileRepository |
| | dataModel | 数据模型 | UserProfileModel |
| | dataSource | 数据源 | UserProfileDataSource |

## 📚 总结

### **架构契约的核心价值**
1. **大模型对齐**: 提供标准化的沟通语言
2. **架构一致性**: 确保设计遵循统一规范
3. **开发效率**: 快速从需求到代码实现

### **使用建议**
- 从简单的自然语言需求开始
- 按照三层架构定义契约
- 使用标准化的节点命名
- 保持契约的简洁和清晰