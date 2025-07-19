import os
import re
import argparse
import urllib.parse
import sys

def find_image_in_static(image_name, static_dir):
    """
    在static/images目录中递归查找图片文件
    返回找到的第一个匹配项，或者None（如果未找到）
    """
    # 解码可能的URL编码字符（如空格%20）
    decoded_name = urllib.parse.unquote(image_name)
    
    # 尝试在static/images目录中查找
    images_dir = os.path.join(static_dir, 'images')
    
    if not os.path.exists(images_dir):
        print(f"警告: 图片目录不存在 - {images_dir}")
        return None
    
    for root, dirs, files in os.walk(images_dir):
        for file in files:
            # 比较文件名（不区分大小写）
            if file.lower() == decoded_name.lower():
                return os.path.join(root, file)
            # 检查是否有URL编码版本的文件名
            if urllib.parse.quote(file) == image_name:
                return os.path.join(root, file)
    
    return None

def update_image_paths_in_file(file_path, static_dir):
    """处理单个Markdown文件，更新图片路径"""
    modified = False
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()
    except Exception as e:
        print(f"无法读取文件 {file_path}: {str(e)}")
        return False
    
    # 正则表达式匹配Markdown图片语法
    pattern = r'!\[(.*?)\]\(([^)]+)\)'
    
    def replace_match(match):
        nonlocal modified
        alt_text = match.group(1)
        img_path = match.group(2)
        
        # 跳过网络图片
        if img_path.startswith(('http://', 'https://')):
            return match.group(0)
        
        # 跳过已经是绝对路径的图片
        if img_path.startswith('/images/'):
            return match.group(0)
        
        # 提取图片文件名
        img_name = os.path.basename(img_path)
        
        # 查找实际图片文件
        actual_path = find_image_in_static(img_name, static_dir)
        
        if actual_path:
            # 转换为Hugo绝对路径
            hugo_path = actual_path.replace(static_dir, '').replace('\\', '/')
            modified = True
            return f'![{alt_text}]({hugo_path})'
        
        # 未找到图片，保持原样
        return match.group(0)
    
    updated_content = re.sub(pattern, replace_match, content)
    
    if modified:
        try:
            with open(file_path, 'w', encoding='utf-8') as f:
                f.write(updated_content)
            return True
        except Exception as e:
            print(f"无法写入文件 {file_path}: {str(e)}")
            return False
    
    return False

def main(content_dir, static_dir):
    """遍历目录处理所有Markdown文件"""
    modified_count = 0
    total_files = 0
    
    print(f"开始处理博客内容目录: {content_dir}")
    print(f"使用的静态资源目录: {os.path.join(static_dir, 'images')}")
    print("-" * 60)
    
    for root, _, files in os.walk(content_dir):
        for file in files:
            if file.lower().endswith(('.md', '.markdown')):
                total_files += 1
                file_path = os.path.join(root, file)
                if update_image_paths_in_file(file_path, static_dir):
                    print(f"[成功] 更新: {file_path}")
                    modified_count += 1
                else:
                    # 显示处理进度
                    if total_files % 10 == 0:
                        print(f"已处理 {total_files} 个文件...")
    
    print("-" * 60)
    print(f"处理完成！扫描了 {total_files} 个Markdown文件")
    print(f"修改了 {modified_count} 个文件中的图片路径")
    print(f"静态图片目录: {os.path.join(static_dir, 'images')}")

if __name__ == "__main__":
    # 设置默认编码为UTF-8，避免Windows中文路径问题
    if sys.version_info.major == 3:
        sys.stdout.reconfigure(encoding='utf-8')
    
    parser = argparse.ArgumentParser(description='智能更新Hugo博客图片路径')
    parser.add_argument('--content', type=str, default='content',
                        help='Hugo内容目录路径 (默认: content)')
    parser.add_argument('--static', type=str, default='static',
                        help='Hugo静态文件目录路径 (默认: static)')
    
    args = parser.parse_args()
    
    # 解析为绝对路径
    content_dir = os.path.abspath(args.content)
    static_dir = os.path.abspath(args.static)
    
    # 验证目录存在
    if not os.path.exists(content_dir):
        print(f"错误: 内容目录不存在 - {content_dir}")
        exit(1)
    
    if not os.path.exists(static_dir):
        print(f"错误: 静态文件目录不存在 - {static_dir}")
        exit(1)
    
    main(content_dir, static_dir)