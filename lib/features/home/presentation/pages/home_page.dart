import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/home_bloc.dart';
import '../widgets/home_widget.dart';
import '../../../core/widgets/common_widgets.dart';

/// Home页面
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Foundation Agents'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<HomeBloc>().add(const RefreshHomeData());
            },
          ),
        ],
      ),
      body: const HomeView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showMessageDialog(context);
        },
        child: const Icon(Icons.edit),
      ),
    );
  }
  
  void _showMessageDialog(BuildContext context) {
    final textController = TextEditingController();
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('更新消息'),
        content: TextField(
          controller: textController,
          decoration: const InputDecoration(
            labelText: '输入新消息',
            hintText: 'Hello World!',
          ),
          maxLines: 3,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('取消'),
          ),
          ElevatedButton(
            onPressed: () {
              if (textController.text.isNotEmpty) {
                context.read<HomeBloc>().add(
                  UpdateHomeMessage(textController.text),
                );
                Navigator.of(context).pop();
              }
            },
            child: const Text('确定'),
          ),
        ],
      ),
    );
  }
}

/// Home页面视图
class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeInitial) {
          // 初始状态，加载数据
          context.read<HomeBloc>().add(const LoadHomeData());
          return const CommonLoadingIndicator(message: '正在加载...');
        }
        
        if (state is HomeLoading) {
          return const CommonLoadingIndicator(message: '正在加载...');
        }
        
        if (state is HomeLoaded) {
          return RefreshIndicator(
            onRefresh: () async {
              context.read<HomeBloc>().add(const RefreshHomeData());
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  HomeWidget(homeEntity: state.homeEntity),
                  const SizedBox(height: 24),
                  _buildInfoSection(context),
                ],
              ),
            ),
          );
        }
        
        if (state is HomeError) {
          return CommonErrorWidget(
            message: state.message,
            onRetry: () {
              context.read<HomeBloc>().add(const LoadHomeData());
            },
          );
        }
        
        return const CommonErrorWidget(
          message: '未知状态',
        );
      },
    );
  }
  
  Widget _buildInfoSection(BuildContext context) {
    return CommonCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '应用信息',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 16),
          _buildInfoRow('架构模式', 'Clean Architecture + BLoC'),
          _buildInfoRow('状态管理', 'flutter_bloc'),
          _buildInfoRow('依赖注入', 'get_it'),
          _buildInfoRow('路由管理', 'go_router'),
          _buildInfoRow('错误处理', 'Either类型 + 自定义错误'),
          _buildInfoRow('主题设计', 'Material 3'),
        ],
      ),
    );
  }
  
  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }
}
